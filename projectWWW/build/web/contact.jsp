

<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
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
        <title>Contact</title>
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
                <div class="feature">
                    <h2>Contact Info</h2>
                    <p class="featurep">This site was developed as a project for the undergraduate course WWW Technolgies from the University of Thessaly, department of ECE.
                        My name is Polikarpos Thomadakis and i am an undergraduate student on the 5th year.
                        Feel free to contact me here : <%=application.getInitParameter("mail") %>
                    </p>             
                </div>
            </div>
            <footer>
                <p id="FootPar">
                    Copyright &#169; Thomadakis Polikarpos , 2014
                </p>
            </footer>
        </div>
    </body>
</html>

