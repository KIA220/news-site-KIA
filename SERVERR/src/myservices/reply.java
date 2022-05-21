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


@WebServlet("/reply")
public class reply extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Connection connection;
    Statement statement;

    public void DBConnection() throws SQLException, ClassNotFoundException {
        String url = "jdbc:sqlite:/opt/tomcat/webapps/reply.db";          
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
    
    public reply() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
        	DBConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
    		e.printStackTrace();
    	}
        try {
        	HttpSession session = request.getSession();
        	getStatement();
            String reply;
            request.setCharacterEncoding("UTF-8");
            reply = request.getParameter("textareareply");
            statement.executeUpdate("INSERT INTO reply (reply) values" + " ('" + reply + "')");
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
