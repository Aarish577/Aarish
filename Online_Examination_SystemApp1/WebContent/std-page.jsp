
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
			<h2>Student Panel</h2>
		</center>
	</div>

	<div class="menu">
		<a href="std-page.jsp" class="button">profile</a>
		 <a class="button" href="exam.jsp">exams</a> 
		<a class="button" href="results.jsp">results</a>
		<a href="controller.jsp?page=logout" class="button"
			style="float: right; background: crimson; color: white">Logout</a>
	</div>

</body>
</html>

