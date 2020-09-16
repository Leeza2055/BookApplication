<%-- 
    Document   : loginvalidate
    Created on : 27 Aug, 2020, 9:10:45 AM
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
        <!--importing java lib files for MD5 encryption-->
        <%@ page import="java.security.MessageDigest"%>
        <!--to import sql package-->
        <%@ page import="java.sql.*"%>
        
        <%= java.util.Calendar.getInstance().getTime()%><br>
        <% 
            String username = request.getParameter("uname");
            String pass = request.getParameter("pwd");
            //code for MD5
            String epassword = pass;
            //digest algorithm 
            MessageDigest alg=MessageDigest.getInstance("MD5");
            //reset the digest
            alg.reset();
            
            //calculate the md5 hash
            alg.update(epassword.getBytes());
            
            byte[] digest=alg.digest();
            
            StringBuffer hashedpassword = new StringBuffer();
            String hx;
            for( int i=0; i<digest.length;i++){
                hx=Integer.toHexString(0xFF & digest[i]);
                //0x03 is equal to 0x3, but as we need 0xFF for out md5
                if(hx.length()==1){hx = "0"+hx;}
                hashedpassword.append(hx);
            }
            
//            codes for accessing database
//            creating database connection con
            Connection con=DriverManager.getConnection("jdbc:derby://localhost:1527/UserInfoDB [leeza on LEEZA]","leeza","leeza@123");
            
            Statement st=con.createStatement();
            
            ResultSet rs;
//            execute the sql query and retrive the data in resultset rs
            rs = st.executeQuery("select * from USERINFO where uid='"+username+"' and pwd='"+hashedpassword.toString()+"'");
            
            if(rs.next()){
            session.setAttribute("userid", username);
            response.sendRedirect("dashboard.jsp");
            }
            else{
//                response.sendRedirect("index.jsp");
                out.println("Invalid user name or password! <a href='index.jsp'>Try again</a>");
            }
        %>
 
        
    </body>
</html>
