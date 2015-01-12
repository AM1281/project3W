<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 

Class.forName("org.mariadb.jdbc.Driver");
Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
Statement st=dbConnection.createStatement();

ResultSet rs2;
%>
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
        <title>My Books</title>
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
        ResultSet rs=st.executeQuery("Select * From book where owner='"+uname+"'");
%>
        <div class="functions">
           <a href="addBook.jsp"> Add a book</a> 
           <a href="deleteBook.jsp">Make a book (un)available</a>
           <a href="myBooks.jsp">My Books</a>
           <a href="showBooks.jsp">Rent a Book</a>
           <a href="rentedBooks.jsp">Rented Books</a>
            <a href="requestPending.jsp">Check My Requests</a>
        </div>
        <h2>My Books</h2>
        <p>If a book has been returned to you please click the respective link (Returned?)</p>
         <table class="table">
        <tr>
            <th class="first">Title</th>
            <th class="second">Status</th>
        </tr>
        <%while(rs.next()){
            String returnedAction="",returned="";
              String rentTo="Available";
            if(rs.getString("available").equals("false")){
                rentTo="Unavailable";
            }
          
            rs2=st.executeQuery("Select ato,dname,id From on_rent,account where afrom='"+session.getAttribute("uname")+"'&& isbn='"+rs.getString(2)+"' && returned=0 && uname=ato ");
            if(rs2.next()){
              rentTo="On rent to "+rs2.getString(2)+"("+rs2.getString(1)+"@uth.gr)";
              returned="(Returned?)";
              returnedAction="bookReturned?id="+rs2.getString(3);}
        %>
            
          <tr>
            <td class="d2"><%=rs.getString(4)%></td>
            <td class="d1"><%=rentTo %><a href="<%=returnedAction%>"><%=returned%></a></td>
        </tr> <%}%>
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