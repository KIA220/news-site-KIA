package myservices;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/ServletIndexPage")
public class ServletIndexPage extends HttpServlet {
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse responce) throws ServletException, IOException {  
    	
        try {
        	DBConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
    		e.printStackTrace();
    	}
        try {
            getStatement();
            String Email, Password, Phone, Region;
            Email = request.getParameter("Email");
            Password = request.getParameter("Password");
            Phone = request.getParameter("Phone");
            Region = request.getParameter("Region");
            
            statement.executeUpdate("INSERT INTO users (Email, Password, Phone, Region) values" + " ('" + Email + "', '"  + Password + "', '"  + Phone + "', '"  + Region + "')");
            statement.close(); 
            getStatement();
        	ResultSet res = statement.executeQuery("SELECT * FROM users");
            while (res.next()) {
            }
            responce.sendRedirect("index.jsp"); //logged-in page
        } catch (SQLException e) {
            e.printStackTrace();
            responce.sendRedirect("errordb.jsp"); 
        }
    }
    public ServletIndexPage() {
        super();
    }
}
