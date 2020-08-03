package com.riveyra;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addCourse")
public class AddCourseServlet extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Connection con =null;
		String query=null;
		PreparedStatement ps=null;
		int result=0;
		int totalmarks=0;
		String coursename=null,time=null;
		HttpSession sess=null;
		PrintWriter out=null;
		try {
			
			out=res.getWriter();
			coursename=req.getParameter("coursename");
			totalmarks=Integer.parseInt(req.getParameter("totalmarks"));
			time=req.getParameter("time");
					// Load the driver class
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//create the connection object
			con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "admin", "admin");
			//prepare the query
			query="insert into courses values(?,?,?)";
			
			sess=req.getSession();
			//create PreparedStatement object
			if(con!=null) {
				ps=con.prepareStatement(query);
			}
			if(ps!=null) {
				ps.setString(1, coursename);
				ps.setInt(2, totalmarks);
				ps.setString(3, time);
				result=ps.executeUpdate();
			}
			if(result!=0) {
				out.println("<script>alert('Course Added Succesfully')</script>");
				RequestDispatcher rd=req.getRequestDispatcher("courses.jsp");
				rd.include(req, res);
			}else {
				out.print("<script>alert('Course not Added')</script>");
				RequestDispatcher rd=req.getRequestDispatcher("courses.jsp");
				rd.include(req, res);
			}
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
		if(ps!=null) {
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con!=null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

}
}
