<%-- 
    Document   : processRegistration
    Created on : 28 Aug, 2020, 9:42:37 AM
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
        <!--database connectivity-->
        <%@ page import="java.sql.*"%>
        <%@ page import="java.util.*"%>
        <%@ page import="javax.mail.*"%>
        <%@ page import="javax.mail.internet.*"%>
        <%@ page import="javax.activation.*"%> 
        
        
        <!--retrieve request parameter-->
        
        <%
            String userid=request.getParameter("userid");
            String pwd=request.getParameter("pwd");
            String emailid=request.getParameter("emailid");
            
            //code for MD5
            String epassword = pwd;
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
            
            Connection con=DriverManager.getConnection("jdbc:derby://localhost:1527/TestDB","username","password");
            
            Statement st=con.createStatement();
            
//            execute the sql query and retrive the data in resultset rs
           int i=st.executeUpdate("insert into USERINFO(uid, pwd, email) values('" +userid+"','"+hashedpassword.toString()+"','"+emailid+"')");
           if(i>0) {
           %>
           <h1> Registration Successful!</h1>
           <%
//           code for automated email before redirecting to index.jsp
            //configuration of SMTP for Gmail
            final String username="###youremail###";
            final String password="###yourpassword###";
            String to=emailid;
            String subject="Registration was successful. Welcome to AIC!";
            String mail="Dear Mr./Ms. "+userid+",\n"+"We heartly welcome you to AIC family. Your password is "+pwd+" Regards\n\n\n AIC";
            Properties prop = new Properties();
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "587");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true"); //TLS
            Session emailsession = Session.getInstance(prop,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });
            //sending email
            try {

            Message message = new MimeMessage(emailsession);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to)
            );
            message.setSubject("Testing Gmail TLS "+subject);
            message.setText(mail);
            Transport.send(message);
            System.out.println("Done");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
            //send redirection
            response.sendRedirect("index.jsp");
           }else{
           response.sendRedirect("userRegistration.jsp");
           }
            %>
            
    </body>
</html>
