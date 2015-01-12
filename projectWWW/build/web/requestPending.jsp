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

%>
<%
    String home="index.html";
    String Accepted;
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
        ResultSet rs=st.executeQuery("Select * From book,account,request where reqfrom='"+uname+"' &&reqto=uname && request.isbn=book.isbn && owner=reqto && seen=0");
        String id;
        
%>
        <div class="functions">
           <a href="addBook.jsp"> Add a book</a> 
           <a href="deleteBook.jsp">Make a book (un)available</a>
           <a href="myBooks.jsp">My Books</a>
           <a href="showBooks.jsp">Rent a Book</a>
           <a href="rentedBooks.jsp">Rented Books</a>
           <a href="requestPending.jsp">Check My Requests</a>
        </div>
        <h2>My Requests </h2>
        <h3>Here is a list of the books you have requested to rent and you havent seen the response yet:</h3>
        <p>Click on the OK button to mark the request as seen and remove it from the list !</p>
         <table class="table">
        <tr>
            <th class="first">Title</th>
            <th class="second">Owner</th>
            <th class="second">Accepted?</th>
            <th class="second">         </th>
        </tr>
        <%while(rs.next()){
            id=rs.getString("id");
            Accepted="N/A";
            if(rs.getString("accepted")==null){
                Accepted="N/A";
            }
            else if(rs.getString("accepted").equals("true")){
                Accepted="Yes";
            }
            else if(rs.getString("accepted").equals("false")){
                Accepted="No";
            }
        %>
            
          <tr>
            <td class="d2"><%=rs.getString("title")%></td>
            <td class="d1"><%=rs.getString("dname")%></td>
            <td class="d1"><%=Accepted%></td>
            <td class="d1"><%if(!Accepted.equals("N/A")){%>   <form action="requestSeen" method="post"> <input type="hidden" name="id" value="<%=id%>"/> <input class="button" type="submit" name="OK" value="OK" />
                </form> <%}%></td>
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