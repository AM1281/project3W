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
public class AddBook extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    ResultSet rs;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        response.setContentType("text/html;charset=UTF-8");
        if(session.getAttribute("uname")==null || session.getAttribute("uname").equals("")){
            response.sendRedirect("login.jsp");
        }
        try (PrintWriter out = response.getWriter()) {
            String title=request.getParameter("title");
            String isbn=request.getParameter("isbn");
            String url=request.getParameter("url-amazon");
            if(!url.contains("amazon.")){
                url="";
            }
            String author=request.getParameter("author");
            String uname=session.getAttribute("uname").toString();
            if(!(uname.equals("") && title.equals("") &&isbn.equals(""))){
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
                Statement st=dbConnection.createStatement();
                    rs=st.executeQuery("Select Count(*) from book where owner='"+uname+"' && isbn='"+isbn+"'");
                    rs.next();
                    if(rs.getInt(1)==0){
                        
                        st.executeQuery("INSERT INTO book(`owner`, `isbn`,`title`,`url`,`writer`) VALUES ('"+uname+"', '"+isbn+"','"+title+"','"+url+"','"+author+"')");
                        response.sendRedirect("addSuccess.html");
                    }
                    else{
                        response.sendRedirect("addBook.jsp?error=1");
                    }
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(AddBook.class.getName()).log(Level.SEVERE, null, ex);
            }
            }
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
