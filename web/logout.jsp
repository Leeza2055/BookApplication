<%-- 
    Document   : logout
    Created on : 28 Aug, 2020, 9:27:25 AM
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
        <%
            session.setAttribute("userid", null);
            session.invalidate();
            response.sendRedirect("index.jsp");
            %>
    </body>
</html>
