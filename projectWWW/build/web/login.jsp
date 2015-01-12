<%-- 
    Document   : login
    Created on : Dec 9, 2014, 8:23:47 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <link rel="stylesheet" href="css/home.css" type="text/css"/>
         <link rel="stylesheet" href="css/login.css" type="text/css"/>
        <title>RentABook-Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div class="loginwrapper">
            <div class="loginform">
                <h1>Login to RentABook</h1>
                <%if( session.getAttribute("uname")==null || session.getAttribute("uname").equals("") ) {%>
                <form action="login" method="POST"> 
                    <p><input type="text" name="uid" value="" placeholder="Username"></p>
                    <p><input type="password" name="pwd" value="" placeholder="Password"></p>
                    <p><input type="submit" value="Login"></p> 
                    <p id="new">Use your academic credentials or return to <a href="index.html">home</a></p>
                </form> <%}else { %><h3>You are already logged in . Go <a href="main.jsp">back</a></h3> <%}%>
            </div>
        </div>
    </body>
</html>
