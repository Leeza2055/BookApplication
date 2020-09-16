<%-- 
    Document   : newjsp
    Created on : 27 Aug, 2020, 8:54:14 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% out.print("welcome to JSP");%>
        <%= "welcome to JSP"%>
        <br>
        <form action="loginvalidate.jsp" method="POST">
            User Name: <input type="text" name="uname"><br>
            Password: <input type="password" name="pwd"><br>
            <input type="submit" value="Login"><br>
            <!--get registered link-->
            Yet not registered! <a href='userRegistration.jsp'>Click</a>
           
        </form>
    </body>
</html>
