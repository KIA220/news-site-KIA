<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
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
    	   found = 1;
          }
       }
}
if(found == 1){RequestDispatcher rd = request.getRequestDispatcher("logged.jsp");
rd.forward(request, response);found = 0;}
    %>
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
    <div id="reg_form">
        <div id="reg_cont">
            <button id="btn_reg_close" onclick="close_reg_form()">X</button>
            <div id="reg_cont_in">
                <form method="post" name="myForm" action="ServletIndexPage" onsubmit="return validate()">
                    <input type="email" name="Email" placeholder="E-Mail" required/>
                    <input name="Password" type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" placeholder="Пароль" required/>
                    <input name="passwCheck" type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" placeholder="Повторите пароль" required/>
                    <input type="text" name="Phone" placeholder="Телефон" pattern="[0-9]{6,11}" title="Just numbers"/>
                    <p><select size="3"  name="Region">
    				<option disabled>Select Region</option>	
    				<option value="1">RU</option>
    				<option selected value="2">GB</option>
    				<option value="3">CH</option>
    				<option value="4">US</option>
   					</select></p>
   					
                    <p id="check123"></p>
                    <input name="capch" placeholder="Решите пример" required/>
                    <div>
                    	<input type="reset" style="height: 40px; "/>
                        <button id="btn_reg_ok" type="submit" onclick="">OK</button>
                    </div>
                </form>
            </div>
            
        </div>
    </div>
    <div id="signin_form">
    	<div id="signin_cont">
            <button id="btn_signin_close" onclick="close_signin_form()">X</button>
            <div id="signin_cont_in">
                <form method="post" name="myForm2" action="ServletIndexPageDefault"  >
                <input type="email" name="Email" placeholder="E-Mail" required/>
                    <input name="Password" type="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" placeholder="Пароль" required/>
                <div>
                    	<input type="reset" style="height: 40px; "/>
                        <button id="btn_signin_ok" type="submit" onclick="">OK</button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <script>
    let myElement = document.querySelector("#reg_form");
    function open_reg_form() {
        myElement.style.display = "inherit";
    }
    function close_reg_form() {
        myElement.style.display = "none";
    }
    let myElement2 = document.querySelector("#signin_form");
    function open_signin_form() {
        myElement2.style.display = "inherit";
    }
    function close_signin_form() {
        myElement2.style.display = "none";
    }
    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min)) + min; //Max not included, min included
    }
    var one = getRandomInt(1, 10);
    var two = getRandomInt(1, 10);
    
    function validate() {
        let x = document.forms["myForm"]["capch"].value;
        if (x != one+two) {
            alert("Пример решен не верно");
            return false;
        }
        let xx = document.forms["myForm"]["Password"].value;
        let y = document.forms["myForm"]["passwCheck"].value;
        if (xx != y ) {
            alert("Пароли не совпадают");
            return false;
      }
      }
    var three = one + " + " + two;
    document.getElementById("check123").textContent += three;
    </script>
    <div id="header">
    	<button id="btn_signin" onclick="open_signin_form()">Войти</button>
        <button id="btn_reg" onclick="open_reg_form()">Регистрация</button>
        
    </div>
    <div id="body">
        Войдите для просмотра контента
    </div>
</body>
</html>