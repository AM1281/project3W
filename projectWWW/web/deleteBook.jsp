

<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    
    String isbn="";
Class.forName("org.mariadb.jdbc.Driver");
Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
Statement st=dbConnection.createStatement();

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
        <title>Welcome</title>
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
        String uname=session.getAttribute("uname").toString();
        ResultSet rs=st.executeQuery("Select * From book where owner='"+uname+"' && available=1 ");
ResultSet rs1=st.executeQuery("Select * From book where owner='"+uname+"' && available=0 && isbn NOT IN (Select isbn from on_rent where afrom=owner && returned=0)");
%>
        <div class="functions">
          <a href="addBook.jsp"> Add a book</a> 
           <a href="deleteBook.jsp">Make a book (un)available</a>
           <a href="myBooks.jsp">My Books</a>
           <a href="showBooks.jsp">Rent a Book</a>
           <a href="rentedBooks.jsp">Rented Books</a>
            <a href="requestPending.jsp">Check My Requests</a>
        </div>
         <h2>These books can be set (un)available </h2>
        <div class="feature">
                    <p class="featurep">Note: You cannot set unavailable a book which is on rent</p>        

        </div>
        <table class="table">
            <tr>
                <th class="first">Book Title</th>
                <th class="second">Action</th>
            </tr>
            <%while(rs.next()){
                isbn=rs.getString(2);
            %>
                <tr>
                <td class="d2"><%=rs.getString(4)%></td>
                <td class="d1"><a href="unavailable?action=0&isbn=<%=isbn%>">Make unavailable</a></td>
            </tr> 
        <%}%>
         <%while(rs1.next()){
                isbn=rs1.getString(2);
            %>
            <tr>
                <td class="d2"><%=rs1.getString(4)%></td>
                <td class="d1"><a href="unavailable?action=1&isbn=<%=isbn%>">Make available</a></td>
            </tr> 
            <%}%>
         </table>
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

