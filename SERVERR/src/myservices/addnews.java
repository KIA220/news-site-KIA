package myservices;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class addnews
 */
@WebServlet("/addnews")
public class addnews extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection connection;
    Statement statement;
	
	public void dbconnection() throws SQLException, ClassNotFoundException {
        String url = "jdbc:sqlite:/opt/tomcat/webapps/addnews.db";          
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
    
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
        	dbconnection();
        } catch (SQLException |ClassNotFoundException e) {
            e.printStackTrace();
    	}
        try {
        	HttpSession session = request.getSession();
            getStatement();
            String addnews;
            request.setCharacterEncoding("UTF-8");
            addnews = request.getParameter("textareaaddnews");
            statement.executeUpdate("INSERT INTO addnews (addnews) values" + " ('" + addnews + "')");
            statement.close(); 
            Cookie[] cookies = request.getCookies();
            if (cookies != null & (session.getAttribute("Role").equals("Admin"))) {
            	response.sendRedirect("adminroom.jsp");
            }
            else if (cookies != null){response.sendRedirect("userroom.jsp");}
    		
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

}
