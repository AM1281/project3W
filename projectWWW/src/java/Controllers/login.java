/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    String uid="";
    String pwd="";
    String name="";
    boolean success=false;
    Connection dbConnection;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            uid=request.getParameter("uid");
            pwd=request.getParameter("pwd");
            HttpSession session = request.getSession(true);
            authenticate();
            if(success){
                session.setAttribute("Dname",name);
                session.setAttribute("uname",uid);
                 Class.forName("org.mariadb.jdbc.Driver");
                dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
                Statement st=dbConnection.createStatement();
               ResultSet rs=st.executeQuery("Select Count(*) From account where uname='"+uid+"'");
                rs.next();
                if(rs.getInt(1)==0){
                    st.executeQuery("INSERT INTO account(`uname`, `dname`) VALUES ('"+uid+"', '"+name+"')");
                }
                response.sendRedirect("main.jsp");
            }
            else{
                session.setAttribute("uname","");
                response.sendRedirect("main.jsp");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
public void authenticate(){
    String distName = null ;
    String base = "ou=people,dc=uth,dc=gr";
    Hashtable srchEnv = new Hashtable(11);
    srchEnv.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
    srchEnv.put("com.sun.jndi.ldap.connect.timeout", "4000");
    srchEnv.put(Context.PROVIDER_URL, "ldap://ldap.uth.gr");
    srchEnv.put(Context.SECURITY_AUTHENTICATION, "simple");
    srchEnv.put(Context.SECURITY_PRINCIPAL, "uid="+uid+",ou=people,dc=uth,dc=gr");
    srchEnv.put(Context.SECURITY_CREDENTIALS, pwd);
    String[] returnAttribute = {"cn"};
    SearchControls srchControls = new SearchControls();
    srchControls.setReturningAttributes(returnAttribute);
    srchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
    String searchFilter = "(uid="+uid+")";
    
        try {
            DirContext srchContext = new InitialDirContext(srchEnv);
            success=true;
            NamingEnumeration srchResponse = srchContext.search(base, searchFilter, srchControls);
            while(srchResponse.hasMoreElements()){
                name = ((SearchResult)(srchResponse.next())).getAttributes().get("cn").toString().replace("cn: ","");
                
            } 
        }catch (NamingException namEx) {
        
        
            success=false;
        }

    }
}
