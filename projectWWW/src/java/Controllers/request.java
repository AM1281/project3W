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
public class request extends HttpServlet {

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
            throws ServletException, IOException{
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
                String reqfrom=uname;
                String reqTo=request.getParameter("to");
                String isbn=request.getParameter("isbn");
                ResultSet rs=st.executeQuery("Select Count(*) From request where reqto='"+reqTo+"' && isbn='"+isbn+"'&& reqfrom='"+reqfrom+"'");
                rs.next();
                if(rs.getInt(1)==0){
                    if(request.getParameter("expireD")==null){
                        response.sendRedirect("finishRequest.jsp?to="+reqTo+"&isbn="+isbn);
                    }else{
                         
                         st.executeUpdate("INSERT INTO request (`reqto`, `reqfrom`, `isbn`, `date`) VALUES ('"+reqTo+"', '"+reqfrom+"', '"+isbn+"','"+request.getParameter("expireD")+"')");
                         response.sendRedirect("requestSuccess.jsp");
                    }
                }else{
                    response.sendRedirect("requestFailed.jsp");}
            }
        } catch (SQLException | ClassNotFoundException ex) {
            response.sendRedirect("requestFailed.jsp");
            Logger.getLogger(request.class.getName()).log(Level.SEVERE, null, ex);
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
