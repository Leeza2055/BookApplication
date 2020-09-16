<%-- 
    Document   : userRegistration
    Created on : 28 Aug, 2020, 9:32:59 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Form</title>
    </head>
    <body>
        <h1>User Registration Form</h1><br>
        <form method="post" action="processRegistration.jsp">
            User ID: <input type="text" name="userid" value=""><br>
            Password: <input type="password" name="pwd" value=""><br>
            Email ID: <input type="text" name="emailid" value=""><br>
            <input type="submit" value="Submit">
            <input type="reset" Value="Reset">
            <br>
            <h1>Already Registered? </h1> <a href="index.jsp">Click here</a>
        </form>
    </body>
</html>
