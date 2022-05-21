package myservices;

import java.io.IOException;
import java.sql.*;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/ServletIndexPageDefault")
public class ServletIndexPageDefault extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection connection;
    Statement statement;   
	public void DBConnection() throws SQLException, ClassNotFoundException {
        String url = "jdbc:sqlite:/opt/tomcat/webapps/userdata.db";          
        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection(url);
        } catch (SQLException e) {
            e.printStackTrace();
            
        }
    }
    public Statement getStatement() {
        try {
            statement = connection.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
            
        }
        return statement;
    }
    public ServletIndexPageDefault() {
        super();
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse responce) throws ServletException, IOException {
		
        HttpSession session = request.getSession();
		
		Cookie[] cookies = request.getCookies();
        String cookieName = "user";
        String cookieMail = "usermail";
        
        try {
        	int foundone = 0;
            DBConnection();
            getStatement();
            String email;
            String password;
            email = request.getParameter("Email");
            password = request.getParameter("Password");
            ResultSet res = statement.executeQuery("SELECT Email, Password, Role FROM users");
            while (res.next()) {
            	if(email.equals(res.getString("Email")) && password.equals(res.getString("Password"))) {
            		try {
                        if(cookies != null) {
                        	String datatemp = email + password;
                        	Cookie cookie1 = new Cookie(cookieName, datatemp);
                        	cookie1.setMaxAge(60*60*24*31);
                            responce.addCookie(cookie1);
                            Cookie cookie2 = new Cookie(cookieMail, email);
                        	cookie2.setMaxAge(60*60*24*31);
                            responce.addCookie(cookie2);
                            session.setAttribute("Role", res.getString("Role"));
                            session.setMaxInactiveInterval(-1);
                            foundone = 1;
                        }
                        else {
                            session.removeAttribute("Role");
                            foundone = 0;
                        }
                        }
            			finally{
            				
            			}
                    
            		try {
            			statement.close();
            			res.close();
                    }
            		catch(SQLException e){
            			e.printStackTrace();
            			
            		}
                    if (cookies != null & (session.getAttribute("Role").equals("Admin"))) {
                    	responce.sendRedirect("adminroom.jsp");
                    }
                    else if (cookies != null){responce.sendRedirect("userroom.jsp");}
            		}
            	
            }
            if(foundone == 0) {responce.sendRedirect("errorpasslogin.jsp");}
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
	}
}
