<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ page import="java.sql.*" %>
<%@ page import="org.sqlite.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Отзывы</title>
</head>
<body>
<%
                Class.forName("org.sqlite.JDBC");
                Connection conn =
                     DriverManager.getConnection("jdbc:sqlite:/opt/tomcat/webapps/addnews.db");
                Statement stat = conn.createStatement();
 
                ResultSet res = stat.executeQuery("SELECT * from addnews;");
 
                while (res.next()) {
                    out.println("<tr>");
                    out.println("<td>" + res.getString("addnews") + "<br>" + "<br>"+"</td>");
                    out.println("</tr>");
                }
 
                res.close();
                conn.close();
            %>
    <form id="formtomain" method="post" action="touserroom" >
    <button id="btn_tomain" type="submit">Вернуться в личный кабинет</button>
    </form>
</body>
</html>