<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>Личный кабинет администратора</title>
<style>        
</style>
</head>
<body>
    <script>
    </script>
    <div id="header">
    <form id="formsignout"  action="logout" >
    <button id="btn_signout" type="submit">Выйти</button>
    </form>
    <form id="formtomain"  action="tomain" >
    <button id="btn_tomain" type="submit">Главная</button>
    </form>
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
        	   <button id="btn_namemail" ><%out.println(cookie.getValue());%></button>
        	<%
        	found = 1;
              }
           }
    }    
    if(found == 0){RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
    rd.forward(request, response);found = 0;}
    %>
    
    
    </div>
    <div id="body">
    <label>Личный кабинет</label>
    <div id=divreply>
        <form id="formreply" name="formreply" method="post" action="reply">
        		<label id="labelreply">Оставьте ваш отзыв</label>
        		<textarea name="textareareply" id="textareareply" rows="3" cols="56" placeholder="Ваш отзыв" spellcheck="true"></textarea>
        	    <button id="btn_reply" type="submit">Отправить</button>
        </form>
    </div>
    <div id=divaddnews>
        <form id="formaddnews" name="formaddnews" method="post" action="addnews">
        	<label id="labeladdnews">Поле для добавления новости</label>
			<!-- <input name="passaddnews" id="passaddnews" type="password"  placeholder="Пароль автора" required/>-->
        	<textarea name="textareaaddnews" id="textareaaddnews" rows="8" cols="56" placeholder="Ваша новость" spellcheck="true"></textarea>
        	    <button id="btn_addnews" type="submit">Добавить</button>
        </form>
    </div>
    </div>
    <form id="formtomain" method="post" action="replyout" >
    <button id="btn_tomain" type="submit">Отзывы других пользователей</button>
    </form>
    <form id="formtomain" method="post" action="addnewsout" >
    <button id="btn_tomain" type="submit">Новости на рассмотрении</button>
    </form>
</body>
<script>
</script>
</html>