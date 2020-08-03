<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>

<html>
<%
	Connection con = null;
	PreparedStatement ps = null;
	String valQuery = null;
	ResultSet rs = null;
	int count = 0;

	String name = null;
	String pass = null;
	
	try {

		name = request.getParameter("username");
		pass = request.getParameter("password");

		//register driver software/translator
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//create Connection obj/path

		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "admin", "admin");
		//create statement obj/vehicle

		//preapre sql query
		valQuery = "select count(*) from user1 where userid=? and password=?";

		if (con != null) {
			ps = con.prepareStatement(valQuery);
		}

		//sending sql query to database
		if (ps != null) {

			ps.setString(1, name);
			ps.setString(2, pass);

			rs = ps.executeQuery();
		}
		
		
		
		if (rs != null) {
			if (rs.next()) {
				count = rs.getInt(1);
			}
		}
		//out.println(rs.hashCode());
		//out.println(count);
		if (count == 0) {
			
			out.println("invalid credentials");
			//response.sendRedirect("dashboard.jsp");
		} else {
			
			//out.println("valid credentials");
			response.sendRedirect("controller.jsp");
			//response.sendRedirect("controller.jsp");
			/* RequestDispatcher rd = null;
			rd = application.getRequestDispatcher("/register.html");
			rd.include(request, response); */
		}
	} //try
	catch (ClassNotFoundException cnfe) {
		System.out.println("class not found exception");
	} //1st catch
	catch (SQLException sqle) {
		sqle.printStackTrace();
	} //2nd catch block
	catch (Exception e) {
		System.out.println("unknown exception");
	} //catch
	finally {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		try {
			ps.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	/*   if(request.getSession().getAttribute("userStatus")!=null){
	  System.out.println("its called");
	if(request.getSession().getAttribute("userStatus").equals("-1")){  
	System.out.println("now inside"); */
%>
</html>