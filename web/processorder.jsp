<%-- 
    Document   : processorder
    Created on : 5 Sep, 2020, 8:45:54 AM
    Author     : Dell
--%>

<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if((session.getAttribute("userid")==null) || (session.getAttribute("userid")=="")){
            %>
            <h1>  You are not logged in!<br></h1> <a href='index.jsp'>Try again</a>
            <%}else{
            %>
            User: <%=session.getAttribute("userid")%>
 
            <a href='logout.jsp'>Sign off</></a>
            <h1> Thank you for ordering....</h1>
            <% 
            String[] ids =request.getParameterValues("id");
            if(ids!=null){
            %>
            <%@page import = "java.sql.*"%>
            <%
                try{
                Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/TestDB","username","password");
                Statement stmt=conn.createStatement();
                String sqlSt;
                int recordUpdated;
                ResultSet rset;
            %>
            <table border="1" cellpadding="3">
                <tr>
                    <th>Author</th>
                    <th>Title</th>
                    <th>Price</th>
                    <th>Qty In Stock</th>
                </tr>
                <%
                    for(int i=0; i<ids.length;i++)
                    {
                        sqlSt="UPDATE bookdetails SET qty = qty - 1 WHERE id ="+ ids[i];
                        recordUpdated = stmt.executeUpdate(sqlSt);
                        //carry out a query to confirm
                        sqlSt="SELECT * FROM bookdetails WHERE id="+ids[i];
                        rset=stmt.executeQuery(sqlSt);
                        while(rset.next()){
                            %>
                            <tr>
                                <td><%= rset.getString("author")%></td>
                                <td><%= rset.getString("title")%></td>
                                <td><%= rset.getString("price")%></td>
                                <td><%= rset.getString("qty")%></td>
                            </tr>
                    <%
                        }
                        rset.close();
                    }
                    %>
                    
             <% }catch(Exception e){}} else{
             %>
             <a href='dashboard.jsp'>Add some books...</></a>
             <%
            }} %>  
                
            </table>
            
    </body>
</html>
