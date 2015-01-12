
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Class.forName("org.mariadb.jdbc.Driver");
Connection dbConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/rent_a_book","root","root");
Statement st=dbConnection.createStatement();
ResultSet rs,rs1;
     String logged="login.jsp";
    String login="Login";
    String home="index.html";
    String isbn =request.getParameter("isbn");
    String reqTo =request.getParameter("to");
if ((session.getAttribute("uname") != null) && !(session.getAttribute("uname").equals(""))) {
    home="main.jsp";
    logged="logout.jsp";
    login="Logout";
}%>
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
                <%if ((session.getAttribute("uname") != null) && !(session.getAttribute("uname").equals(""))) {
                    rs=st.executeQuery("Select title from book where isbn='"+request.getParameter("isbn")+"'");
                    rs1=st.executeQuery("Select dname from account where uname='"+request.getParameter("to")+"'");
                    if(rs.next()&&rs1.next()){
                %>
                <h2>Almost done!</h2>
                <p>You are going to request book <%=rs.getString("title")%> from <%=rs1.getString("dname")%> <br/>
                    Please provide the date you wish the rent to expire starting from today : 
                </p>
                <form method="post" action="request">
                    <input type="date" name="expireD">
                    <input type="hidden" name="to" value="<%=reqTo%>" >
                    <input type="hidden" name="isbn" value="<%=isbn%>" >
                    <input type="submit" >
                </form>
                <%}}else{%>
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
