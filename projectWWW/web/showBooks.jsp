<%-- 
    Document   : showBooks
    Created on : Dec 7, 2014, 5:23:00 PM
    Author     : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
     String logged="login.jsp";
    String login="Login";
    String home="index.html";
if ((session.getAttribute("uname") != null) && !(session.getAttribute("uname").equals(""))) {
    home="main.jsp";
    logged="logout.jsp";
    login="Logout";
}%>
<%Class.forName("org.mariadb.jdbc.Driver");
Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
Statement st=dbConnection.createStatement();
ResultSet rs=st.executeQuery("Select Distinct title,isbn From book ");  
String av="Yes",link="login.jsp";
if(session.getAttribute("uname")!=null && !session.getAttribute("uname").equals("")){
    link="addBook.jsp";
}
%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/home.css">
        <title>Books</title>
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
                
                <h2>Books in database </h2>
                <div class="feature">
                    <p class="featurep">You can extend this list by <a href="<%=link%>">adding</a> more books.</p>
      <table class="table">
        <tr>
            <th class="first">Title</th>
            <th class="second">Available?</th>
        </tr>
            <% while(rs.next()){%>
            <% ResultSet rs2=st.executeQuery("Select Count(*) from book where isbn='"+rs.getString("isbn")+"' && available=1"); 
            rs2.next();
                if(rs2.getInt(1)>0){
                 av="Yes";
                }else av="No";
            %>
        <tr>
            <td class="d2"><a href="bookDetails.jsp?isbn=<%=rs.getString("isbn")%>"><%=rs.getString(1)%></a></td>
            <td class="d1"><%=av %></td>
        </tr>
        <% }%>
      </table>
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
