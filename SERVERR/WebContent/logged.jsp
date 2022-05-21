<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%><%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>Новостной портал</title>
<style>        
</style>
</head>
<body>
    <script>
    </script>
    <div id="header">
        
    <%
    Cookie[] cookies = request.getCookies();
    String cookieName = "user";
    String cookieMail = "usermail";
    Cookie cookie = null;
    int found = 0;
    if(cookies !=null) {
        for(Cookie c: cookies) {
            if(cookieMail.equals(c.getName())) {
                cookie = c;
                break;
            }
        }
    }
    if(cookies !=null) {
       for(Cookie c: cookies) {
           if(cookieName.equals(c.getName())) {
        	   %>
        	   <form id="formtouserroom" action="touserroom" >
        	    <button id="btn_signout" type="submit"><%out.println(cookie.getValue());%></button>
        	    </form>
        	    <%
        	    found = 1;
              }
           }
    }    
    if(found == 0){RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
    rd.forward(request, response);found = 0;}
    %>
    
    <form id="formsignout"action="logout" >
    <button id="btn_signout" type="submit">Выйти</button>
    </form>
    </div>
    <div id="bodyContent">
        
        <div id="ContentLogged">
        <%
        	Class.forName("org.sqlite.JDBC");
            Connection conn =
                    DriverManager.getConnection("jdbc:sqlite:/opt/tomcat/webapps/addnews.db");
               Statement stat = conn.createStatement();

               ResultSet res = stat.executeQuery("SELECT * from addnews;");

               while (res.next()) {%><form method="post"action="delete"><div id="ContentBlock"><div id="ContentPictureBlock"><img src="photo.jpg"></div><div id="ContentTextBlock"><% 
                   out.println("<tr>");
                   out.println("<td>" + res.getString("addnews") + "<br>" + "<br>"+"</td>");
                   out.println("</tr>");%></div><%
                   if (cookies != null & (session.getAttribute("Role").equals("Admin"))) {
                  		%><input type="hidden" name="ID" value="<%out.print(res.getString("ID"));
                  		%>"><button type="submit">Удалить</button><%}%></div></form>
               <% 
               }
               res.close();
               conn.close(); %>
        </div>
    </div>
</body>
</html>