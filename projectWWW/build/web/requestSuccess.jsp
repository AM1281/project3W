<%-- 
    Document   : requestSuccess
    Created on : Dec 24, 2014, 11:58:06 AM
    Author     : Admin
--%>


<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
        Class.forName("org.mariadb.jdbc.Driver");
Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
Statement st=dbConnection.createStatement();
ResultSet rs;
    
    String to,isbn,date;
    to=request.getParameter("to");
    isbn=request.getParameter("isbn");
    date=request.getParameter("expirationD");
    String home="index.html";
    String logged="login.jsp";
    String login="Login";
if ((session.getAttribute("uname") != null) && !(session.getAttribute("uname").equals(""))) {
    home="main.jsp";
    logged="logout.jsp";
    login="Logout";
}%>
<html>
    <head>
        <link rel="stylesheet" href="css/home.css">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Request</title>
    </head>
    <body>
        <div class="page-wrapper">
            <header class="header">
                <h1 ><a href="<%=home %>"> <img id="logo" src="Logo.gif" alt="RentABook"> </a></h1>
                <nav>
                <ul>
                    <li ><a class="nav-link" href="<%=home %>">Home</a></li>
                    <li ><a class="nav-link" href="showBooks.jsp">Books</a></li>
                    <li ><a class="nav-link" href="contact.jsp">Contact</a></li>
                </ul>
            </nav>
                 <span class="login">
                    <a style=color:#F38630; href="<%=logged%>"><%=login%></a>
                </span>
            </header>
            <div class="mainPage">

<%  request.setCharacterEncoding("UTF-8");
    if ((session.getAttribute("uname") != null) && !(session.getAttribute("uname").equals(""))) {
%>

        <div class="functions">
            <a href="addBook.jsp"> Add a book</a> 
           <a href="deleteBook.jsp">Make a book (un)available</a>
           <a href="myBooks.jsp">My Books</a>
           <a href="showBooks.jsp">Rent a Book</a>
           <a href="rentedBooks.jsp">Rented Books</a>
            <a href="requestPending.jsp">Check My Requests</a>
        </div>
        <h2>Success</h2>
        <p class="featurep">A request for rent has been sent successfully, you will be informed when the owner responds to your request.</p>             
    <%}else{%>
        <h4>Invalid credentials.Please <a href="login.jsp">login</a> again </h4>
    <%}%>
     </div>
            <footer>
                <p id="FootPar">
                    Copyright &#169; Thomadakis Polikarpos , 2014
                </p>
            </footer>
        </div>
    </body>
</html>


