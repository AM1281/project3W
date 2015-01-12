

<%@page import="java.text.SimpleDateFormat"%>
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
        String uname= session.getAttribute("uname").toString();
%>
        
        <h2>Hello <%=session.getAttribute("Dname")%> </h2>
        <div class="functions">
            <a href="addBook.jsp"> Add a book</a> 
           <a href="deleteBook.jsp">Make a book (un)available</a>
           <a href="myBooks.jsp">My Books</a>
           <a href="showBooks.jsp">Rent a Book</a>
           <a href="rentedBooks.jsp">Rented Books</a>
            <a href="requestPending.jsp">Check My Requests</a>
        </div>
        <%java.util.Date now = new java.util.Date();
        rs=st.executeQuery("Select * from on_rent where ato='"+uname+"' && returned=0 && expires<='"+new SimpleDateFormat("yyyy-MM-dd").format(now)+"'"); 
        if(rs.next())
            %><h3 style="font-style:oblique; ">You have some books expired or expiring today!Check your <a href="rentedBooks.jsp" >books</a></h3>
         <h3>New Requests :</h3>
        <% rs=st.executeQuery("Select reqfrom,title,dname,rating,book.isbn,date From request,book,account where reqto='"+session.getAttribute("uname")+"'&& book.isbn=request.isbn && accepted IS NULL && account.uname=reqfrom");
        if(!rs.next()){%><p>No new requests at the time!</p><%}else{%>
        <p>You have some new requests for rent!</p>
            <table class="table">
        <tr>
            <th class="first">Name</th>
            <th class="second">Rating</th>
            <th class="second">Book</th>
            <th class="second">Until</th>
            <th class="second">Action</th>
        </tr>
           <% do{
            %><tr>
                <td class="d2"><%=rs.getString("dname")%></td>
                <%
                rs.getString("rating");
                if(rs.wasNull()){
                    %><td>N/A</td>
                <%}else{%> <td class="d1"><%=rs.getString("rating")%></td><%}%>
                <td class="d1"><%=rs.getString("title")%></td>
                <td><%=rs.getString("date") %></td>
                <td class="d1"><form method="post" action="respond">
                        <input type="hidden" name="isbn" value="<%=rs.getString("book.isbn") %>" />
                        <input type="hidden" name="from" value="<%=rs.getString("reqfrom")%>">
                        <input type="hidden" name="expD" value="<%=rs.getString("date")%>">
                        <input class="button" type="submit" name="action" value="Accept"/>
                        <input class="button" type="submit" name="action" value="Reject"/>
                </form> 
                </td>
            <%}while(rs.next());%>
         </table>
                <%}%>
        
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

