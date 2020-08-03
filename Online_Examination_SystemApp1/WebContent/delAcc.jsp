<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
		Connection con = null;
		PreparedStatement ps = null;
		int result = 0;
		String value = null;
		String DEL_ACC_DETAILS = null;

		value = request.getParameter("checkbox");
		System.out.println(value);

		Class.forName("oracle.jdbc.driver.OracleDriver");

		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "admin", "admin");

		DEL_ACC_DETAILS = "delete from user1 where userid=?";

		if (con != null) {
			ps = con.prepareStatement(DEL_ACC_DETAILS);
		}

		if (ps != null) {
			ps.setString(1, value);

			result = ps.executeUpdate();
		}
		
		System.out.println(result);

		if (result == 0) {
			out.println("<script>alert('User Not Deleted')</script>");
			response.sendRedirect("accounts.jsp");
		} else {
			out.println("<script>alert('User Deleted Successfully')</script>");
			response.sendRedirect("accounts.jsp");
		}

		ps.close();
		con.close();
	%>


</body>
</html>