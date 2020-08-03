
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="pDAO" class="com.riveyra.DatabaseClass" scope="page" />
<!DOCTYPE html>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="style-backend.css">

<style type="text/css">
.menu {
	margin-top: 75px;
	color: black;
}
</style>
</head>
<body>
	<div class="top-area">
		<center>
			<h2>Admin Panel</h2>
		</center>
	</div>
	<div class="menu">
		<a href="adm-page.jsp" class="button">Home</a> <a class="button"
			href="accounts.jsp">Accounts</a> <a class="button" href="courses.jsp">Courses</a>
		<a class="button" href="questions.jsp">Questions</a> <a class="button"
			href="showall.jsp">Showall</a> <a class="button" href="profile.jsp">Profile</a>
		<a href="controller.jsp?page=logout" class="button"
			style="float: right; background: crimson; color: white">Logout</a>
	</div>
</body>
</html>