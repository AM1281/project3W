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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class respond extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session=request.getSession();
            if(session.getAttribute("uname")==null || session.getAttribute("uname").equals("")){
                response.sendRedirect("login.jsp");
            }else{
                String uname=session.getAttribute("uname").toString();
                Class.forName("org.mariadb.jdbc.Driver");
                Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
                Statement st=dbConnection.createStatement();
                int id;
                ResultSet rs;
                if(session.getAttribute("uname")==null||session.getAttribute("uname").equals("")){
                    response.sendRedirect("login.jsp");
                }
                String action=request.getParameter("action");
                String from=request.getParameter("from");
                String isbn=request.getParameter("isbn");
                String date=request.getParameter("expD");
                rs= st.executeQuery("Select id from request where isbn='"+isbn+"' && reqfrom='"+from+"' && reqto='"+uname+"'");
                rs.next();
                id=rs.getInt("id");
                if(action.equals("Reject")){
                    st.executeUpdate("UPDATE request SET accepted=b'0' WHERE  id="+id);
                    response.sendRedirect("main.jsp");
                }
                else  if(action.equals("Accept")){
                    st.executeUpdate("UPDATE request SET accepted=b'1' WHERE  id="+id);
                    st.executeUpdate("UPDATE book SET available=b'0' WHERE  owner='"+uname+"' && isbn='"+isbn+"'");
                    st.executeUpdate("INSERT INTO on_rent (afrom,ato,isbn,expires) VALUES ('"+uname+"', '"+ from+"', '"+isbn+"', '"+date+"') ");
                    request.setAttribute("mail",from+"@uth.gr" );
                    request.getRequestDispatcher("requestAccept.jsp").forward(request, response);
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(respond.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(respond.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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

}
