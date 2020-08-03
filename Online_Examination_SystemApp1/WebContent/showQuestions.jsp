<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class="sidebar" style="background-image: url(sidebar-1.jpg)">
		<div class="sidebar-background">
			<h2 class="logo-text">Online Examination System</h2>

			<div class="left-menu">
				<a href="adm-page.jsp"><h2>Profile</h2></a> <a
					href="courses.jsp"><h2>Courses</h2></a> <a class="active"
					href="questions.jsp"><h2>Questions</h2></a> <a
					href="accounts.jsp"><h2>Accounts</h2></a>
			</div>
		</div>
	</div>
	<div class="content-area">
		<%
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String GET_QUESTIONS = null;
			int count = 0;

			Class.forName("oracle.jdbc.driver.OracleDriver");

			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "admin", "admin");

			GET_QUESTIONS = "select  question_id, question from questions";

			if (con != null) {
				ps = con.prepareStatement(GET_QUESTIONS);
			}

			if (ps != null) {
				rs = ps.executeQuery();
			}

			if (rs != null) {

				out.println(
						"<div style='overflow-x:auto;'><center><caption><h2 style='color:red; margin-left:10px'>Questions");
				out.println(
						"</h2></caption><table border='1' style='width:90%; text-align:left; border-spacing:0px'>");
				out.println("<tr style='background-color:black;color:white'><th>Question ID</th><th>Question</th>");
				out.println("<th>Delete Question</th></tr>");

				while (rs.next()) {

					out.println("<tr><td>" + rs.getInt(1) + "</td>");
					out.println("<td>" + rs.getString(2) + "</td>");
					out.println(
							"<td><form action='delQues.jsp' method='post'><input type='checkbox' name='checkbox' value='"
									+ rs.getInt(1)
									+ "' style='width:10%'><input type='submit' name='submit' value='Delete' style='width:90%'></form></td></tr>");
				}
			}

			rs.close();
			ps.close();
			con.close();
		%>

		<table>
			<tr>
				<td></td>
			</tr>

		</table>
	</div>
</body>
</html>
