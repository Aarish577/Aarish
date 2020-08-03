package com.riveyra;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/rurl")
public class RegisterServlet extends HttpServlet {
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Connection con =null;
		String query=null;
		PreparedStatement ps=null;
		int result=0;
		int userid=0;
		String fname=null,lname=null,username=null,email=null,password=null;
		String usertype=null,contactno=null,city=null,address=null;
		HttpSession sess=null;
		PrintWriter out=null;
		try {
			
			out=res.getWriter();
			userid=Integer.parseInt(req.getParameter("userid"));
			fname=req.getParameter("fname");
			lname=req.getParameter("lname");
			username=req.getParameter("uname");
			email=req.getParameter("email");
			password=req.getParameter("pass");
			usertype=req.getParameter("usertype");
			contactno=req.getParameter("contactno");
			city=req.getParameter("city");
			address=req.getParameter("address");
					// Load the driver class
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//create the connection object
			con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "admin", "admin");
			//prepare the query
			query="insert into user1 values(?,?,?,?,?,?,?,?,?,?)";
			
			sess=req.getSession();
			//create PreparedStatement object
			if(con!=null) {
				ps=con.prepareStatement(query);
			}
			if(ps!=null) {
				ps.setInt(1, userid);
				ps.setString(2, fname);
				ps.setString(3, lname);
				ps.setString(4, username);
				ps.setString(5, email);
				ps.setString(6, password);
				ps.setString(7, usertype);
				ps.setString(8, contactno);
				ps.setString(9, city);
				ps.setString(10, address);
				result=ps.executeUpdate();
			}
			if(result!=0) {
				out.println("<script>alert('User Added Succesfully')</script>");
				RequestDispatcher rd=req.getRequestDispatcher("accounts.jsp");
				rd.include(req, res);
			}else {
				out.print("<script>alert('User not Added')</script>");
				RequestDispatcher rd=req.getRequestDispatcher("accounts.jsp");
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
