<%-- 
    Document   : addBook
    Created on : Dec 9, 2014, 5:41:26 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error=request.getParameter("error");
    if(error==null){
        error="";
    }
    String logged="login.jsp";
    String login="Login";
    String home="index.html";
if ((session.getAttribute("uname") != null) && !(session.getAttribute("uname").equals(""))) {
    home="main.jsp";
     logged="logout.jsp";
    login="Logout";
}%>
<html>
    <head>
        <link rel="stylesheet" href="css/home.css">
        <title>Add a Book</title>
        <meta charset="UTF-8">
        
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            <% if ((session.getAttribute("uname") != null)&& !session.getAttribute("uname").equals("")) {%>
            <div class="functions">
           <a href="addBook.jsp"> Add a book</a> 
           <a href="deleteBook.jsp">Make a book (un)available</a>
           <a href="myBooks.jsp">My Books</a>
           <a href="showBooks.jsp">Rent a Book</a>
           <a href="rentedBooks.jsp">Rented Books</a>
            <a href="requestPending.jsp">Check My Requests</a>
            </div>
                <form method="post" name="add-book" id="add-book" action="AddBook">
                    <fieldset>
			<legend>Add a Book</legend>
			<dl>
				<dt>
					<label for="title">Title(required)</label>
				</dt>
				<dd><input type="text" id="title" name="title" required ></dd>
			</dl>
			<dl>
				<dt>
					<label for="isbn">ISBN(required)</label>
				</dt>
				<dd><input type="text" id="isbn"  name="isbn" required  ></dd>
			</dl>
			<dl>
				<dt>
					<label for="author">Author</label>
				</dt>
				<dd><input type="text" id="author" name="author" /></dd>
			</dl>
			<dl>
				<dt>
					<label for="url-amazon">Link in amazon (If link is not in amazon it will be left blank)</label>
				</dt>
				<dd><input type="text" id="url-amazon" name="url-amazon" /></dd>
			</dl>
			<div id="submit_buttons">
				<button type="submit">Submit</button>
			</div>
                    </fieldset>
                </form>
            <%if(!error.equals("")){%>
            <h4>Sorry,you cannot add the same book twice.</h4><%}%>
            <%} else{%>
            <h3>You need to <a href="login.jsp">login</a> to add a book</h3><%}%>
        </div>
        <footer>
            <p id="FootPar">
                    Copyright &#169; Thomadakis Polikarpos , 2014
            </p>
        </footer>
        </div>
    </body>
</html>
