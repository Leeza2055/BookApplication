<%-- 
    Document   : dashboard
    Created on : 27 Aug, 2020, 9:52:03 AM
    Author     : Dell
    at top for MySQL
    <% Class.forName("com.mysql.jdbc.Driver"); %>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!--validating user before loading page-->
        <%
            
            if((session.getAttribute("userid")==null) || (session.getAttribute("userid")=="")){
            %>
            <h1>  You are not logged in!<br></h1> <a href='index.jsp'>Try again</a>
            <%}else{
            %>
        Admin: <%=session.getAttribute("userid")%>
        <a href='logout.jsp'>Sign off</></a>
        <h1>Dashboard Page! </h1>
        <a href='loginInfo.jsp'>Profile</></a><br>
        <%@page import = "java.sql.*"%>
        <h2>List of Books Available</h2>
        <h3>Choose Author!</h3>
        <form method="get">
            <input type="checkbox" name="author" value="Balagurusamy"> E. Balagurusamy
            <input type="checkbox" name="author" value="Shield"> H. Shield
            <input type="submit" value="Query">
        </form>
        <%
            String sqlSt="";
            String[] authors = request.getParameterValues("author");
            Connection conn=DriverManager.getConnection("jdbc:derby://localhost:1527/TestDB","username","password");
            Statement stmt=conn.createStatement();
            
            if(authors!=null){
                sqlSt+="SELECT * FROM bookdetails where author IN(";
                sqlSt+="'"+authors[0]+"'";//First selected author
                for(int i=1; i<authors.length;i++){
                    sqlSt+=", '"+authors[i]+"'";//Subsequent authors with leading comas
                }
                sqlSt+=") AND qty > 0 ORDER BY author ASC, title ASC";
            }
            else{
                    
                    sqlSt+="SELECT * FROM bookdetails where qty > 0 ORDER BY author ASC, title ASC";
                }  
            System.out.println("Query Statement:"+sqlSt);
            ResultSet rset=stmt.executeQuery(sqlSt);
            %>
            <hr>
            <form method="post" action="processorder.jsp">
                <table border="1" cellpadding="5">
                    <tr>
                        <th>Order</th>
                        <th>Author</th>
                        <th>Title</th>
                        <th>Price</th>
                        <th>Available Qty.</th>
                    </tr>
                    <%
                    
                    while(rset.next()){
                        int id=rset.getInt("id");
                        %>
                        <tr>
                            <td><input type="checkbox" name="id" value="<%=id%>"></td>
                            <td><%= rset.getString("author") %></td>
                            <td><%= rset.getString("title") %></td>
                            <td><%= rset.getString("price") %></td>
                            <td><%= rset.getString("qty") %></td>
                        </tr>
                        <%
                    }
                    %>
                </table>
                <input type="submit" value="Order">
                <input type="reset" value="Clear">
            </form>
                
        <%rset.close(); stmt.close();conn.close();}
        %>
    </body>
</html>
