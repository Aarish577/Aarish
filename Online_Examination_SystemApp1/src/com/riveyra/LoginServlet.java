package com.riveyra;

import java.io.IOException;

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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Connection con = null;
		String query = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int userid = 0;
		String password = null;
		HttpSession sess = null;
		
		
		try {

			
			userid = Integer.parseInt(req.getParameter("username"));
			password = req.getParameter("password");
			// Load the driver class
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// create the connection object
			
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "admin", "admin");
			// prepare the query
			
			query = "select * from user1 where userid=? and password=?";

			sess = req.getSession();
			// create PreparedStatement object
			if (con != null) {
				ps = con.prepareStatement(query);
			}
			if (ps != null) {
				ps.setInt(1, userid);
				ps.setString(2, password);
				rs = ps.executeQuery();
			}
			if (rs != null) {
				if (rs.next()) {
					
					//System.out.println("loginserv");

					sess.setAttribute("user_id", rs.getInt(1));
					sess.setAttribute("password", rs.getString(6));
					
					//System.out.println(sess.getAttribute("password"));
					//System.out.println(sess.getAttribute("user_id"));
					//System.out.println(rs.getString(7));

					if (rs.getString(7).equals("admin")) {
						System.out.println(rs.getString(7));
						RequestDispatcher rd=req.getRequestDispatcher("adm-page.jsp");
						rd.include(req, res);
					} else if (rs.getString(7).equals("student")) {
						System.out.println(rs.getString(7));
						RequestDispatcher rd=req.getRequestDispatcher("std-page.jsp");
						rd.include(req, res);
					}

				} 
			}
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

	}

}
