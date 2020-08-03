
<%@page import="com.riveyra.User"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="pDAO" class="com.riveyra.DatabaseClass" scope="page" />

<!-- SIDEBAR -->
<div class="sidebar" style="background-image: url(sidebar-1.jpg)">
	<div class="sidebar-background">
		<h2 class="logo-text">Online Examination System</h2>

		<div class="left-menu">
			<a href="adm-page.jsp"><h2>Profile</h2></a> <a href="courses.jsp"><h2>Courses</h2></a>
			<a href="questions.jsp"><h2>Questions</h2></a> <a
				class="active" href="accounts.jsp"><h2>Accounts</h2></a>
		</div>
	</div>
</div>
<!-- CONTENT AREA -->
<div class="content-area">
	<div class="inner" style="margin-top: 50px">
		<div class="title" style="margin-top: -30px">List of All
			Registered Persons</div>

		<br> <br> <br /> <a href="register.html" class="button"><span
			class="add-btn" style="margin-left: 80px;">Add New Person</span></a> <br>


		<table id="one-column-emphasis">
			<colgroup>
				<col class="oce-first" />
			</colgroup>
			<thead>
				<tr>
				    <th scope="col">UserID</th>
					<th scope="col">Name</th>
					<th scope="col">email</th>
					<th scope="col">City</th>
					<th scope="col">Address</th>
					<th scope="col">Action</th>

				</tr>
			</thead>
			<tbody>
				<%
					ArrayList list = pDAO.getAllUsers();
					User user;
					int uid=0;
					for (int i = 0; i < list.size(); i++) {
						user = (User) list.get(i);
						if (user.getUserId() != Integer.parseInt(session.getAttribute("user_id").toString())) {
							
							uid=user.getUserId();
							System.out.println(uid);
				%>

				<tr>
				    <td><%=user.getUserId()%></td>
					<td><%=user.getFirstName() + " " + user.getLastName()%></td>
					<td><%=user.getEmail()%></td>
					<td><%=user.getCity()%></td>
					<td><%=user.getAddress()%></td>
					<td><form action='delAcc.jsp' method='post'>
							<input type='checkbox' name='checkbox'
								value="<%=user.getUserId()%>" style='width: 10%'> <input
								type='submit' name='submit' value='Delete' style='width: 90%'>
						</form></td>
					</td>

				</tr>



				<%
					}
					}
				%>

			</tbody>
		</table>


	</div>
</div>