<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Questions</title>
</head>
<body>

	<%
		Connection con = null;
		PreparedStatement ps = null;
		int result = 0;
		String value = null;
		String DEL_QUES = null;

		value = request.getParameter("checkbox");
		System.out.println(value);

		Class.forName("oracle.jdbc.driver.OracleDriver");

		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "admin", "admin");

		DEL_QUES = "delete from questions where question_id=?";

		if (con != null) {
			ps = con.prepareStatement(DEL_QUES);
		}

		if (ps != null) {
			ps.setString(1, value);

			result = ps.executeUpdate();
		}
		
		System.out.println(result);

		if (result == 0) {
			out.println("<script>alert('Question Not Deleted')</script>");
			response.sendRedirect("showQuestions.jsp");
		} else {
			out.println("<script>alert('Question Deleted Successfully')</script>");
			response.sendRedirect("showQuestions.jsp");
			
		}

		ps.close();
		con.close();
	%>


</body>
</html>