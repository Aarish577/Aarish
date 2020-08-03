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

@WebServlet("/addques")
public class AddQuestionServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Connection con =null;
		String query=null;
		PreparedStatement ps=null;
		int result=0;
		int questionid=0;
		String course=null,question=null,opt1=null,opt2=null,opt3=null;
		String opt4=null,correct=null;
		PrintWriter out=null;
		HttpSession sess=null;
		try {
			
			out=res.getWriter();
			questionid=Integer.parseInt(req.getParameter("questionid"));
			course=req.getParameter("coursename");
			question=req.getParameter("question");
			opt1=req.getParameter("opt1");
			opt2=req.getParameter("opt2");
			opt3=req.getParameter("opt3");
			opt4=req.getParameter("opt4");
			correct=req.getParameter("correct");
					// Load the driver class
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//create the connection object
			con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "admin", "admin");
			//prepare the query
			query="insert into questions values(?,?,?,?,?,?,?,?)";
			
			sess=req.getSession();
			//create PreparedStatement object
			if(con!=null) {
				ps=con.prepareStatement(query);
			}
			if(ps!=null) {
				ps.setInt(1, questionid);
				ps.setString(2, course);
				ps.setString(3, question);
				ps.setString(4, opt1);
				ps.setString(5, opt2);
				ps.setString(6, opt3);
				ps.setString(7, opt4);
				ps.setString(8, correct);
				result=ps.executeUpdate();
			}
			if(result!=0) {
				out.println("<script>alert('Question Added Succesfully')</script>");
				RequestDispatcher rd=req.getRequestDispatcher("questions.jsp");
				rd.include(req, res);
			}else {
				out.print("<script>alert('Question not Added')</script>");
				RequestDispatcher rd=req.getRequestDispatcher("questions.jsp");
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
