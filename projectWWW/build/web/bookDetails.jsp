

<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    Class.forName("org.mariadb.jdbc.Driver");
Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
Statement st=dbConnection.createStatement();
ResultSet rs;
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

<%  String isbn =request.getParameter("isbn");
    String title ="Sorry this book doesnt exist anymore";
    String url="",author="";
    int counter=0;
    rs=st.executeQuery("Select * From book where isbn='"+isbn+"'");
    while(rs.next()){
        title=rs.getString("title");
        rs.getString("url");
        if(!rs.wasNull()){
            url=rs.getString("url");
        }
        rs.getString("writer");
        if(!rs.wasNull()){
            author=rs.getString("writer");
        }
        counter++;
    }
%>
    <h2><%=title %></h2>
    <table class="horizontal">
        <tr><th>Number of copies</th><td><%=counter%></td></tr>
        <tr><th>Author</th><td><%=author%></td></tr>
        <tr><th>Link in Amazon.com<td><%=url%></td></tr>
    </table>
    <%if ((session.getAttribute("uname") != null) && !(session.getAttribute("uname").equals(""))) {
       rs=st.executeQuery("Select dname,rating,available,uname from account,book where isbn='"+isbn+"' && owner=uname" );    %>
       <h3>Here is a list of members who own this book :</h3>
            <table class="table">
        <tr>
            <th class="first">Name</th>
            <th class="second">Rate</th>
            <th class="second">Available?</th>
            <th class="second">Request it</th>
        </tr>
        <%while(rs.next()){
           String rate=rs.getString(2),avl,requestIt="Request it";
            if(rs.wasNull()){
               rate="N/A";
            }
            avl="No";
            if(rs.getBoolean(3)){
                avl="Yes";
            }
            if(avl.equals("No")||session.getAttribute("uname").equals(rs.getString("uname"))){
                //Den mporei na pathsei to link
                requestIt="";
            }
        %>
        <tr>
            <td class="d2"><%=rs.getString(1)%></td>
            <td class="d1"><%=rate %></td>
            <td class="d1"><%=avl %></td>
            <td class="d1"><a href="request?to=<%=rs.getString("uname")%>&isbn=<%=isbn%>"><%=requestIt%></a></td>
        </tr>
           <% }%>
      </table>
    <%}else{%>
    <h3>You need to <a href="login.jsp">login</a>to view who owns this book.</h3><%}%>
     </div>
            <footer>
                <p id="FootPar">
                    Copyright &#169; Thomadakis Polikarpos , 2014
                </p>
            </footer>
        </div>
    </body>
</html>

