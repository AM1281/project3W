/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
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
public class unavailable extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            HttpSession session=request.getSession();
            if ((session.getAttribute("uname") != null) && !(session.getAttribute("uname").equals(""))) { 
                Class.forName("org.mariadb.jdbc.Driver");
                String uname=session.getAttribute("uname").toString();
                Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
                Statement st=dbConnection.createStatement();
                if(request.getParameter("action").equals("0")){
                    ResultSet rs=st.executeQuery("Select * From book where owner='"+uname+"' && isbn='"+request.getParameter("isbn")+"' && available=1");
                    if(rs.next()){
                        st.executeUpdate("UPDATE book SET available=b'0' WHERE  isbn='"+request.getParameter("isbn")+"' AND owner='"+uname+"'");
                        response.sendRedirect("deleteBook.jsp");
                    }
                }
                else if(request.getParameter("action").equals("1")){
                    ResultSet rs=st.executeQuery("Select Count(*) From on_rent where afrom='"+uname+"' && isbn='"+request.getParameter("isbn")+"' && returned=0");
                    rs.next();
                    if(rs.getInt(1)>0){
                        response.sendRedirect("deleteBook.jsp");
                    }
                    else{
                        st.executeUpdate("UPDATE book SET available=b'1' WHERE  isbn='"+request.getParameter("isbn")+"' AND owner='"+uname+"'");
                        response.sendRedirect("deleteBook.jsp");
                    }
                }
            }else if(session.getAttribute("uname")==null || session.getAttribute("uname").equals("")){
                response.sendRedirect("login.jsp");
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(unavailable.class.getName()).log(Level.SEVERE, null, ex);
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
