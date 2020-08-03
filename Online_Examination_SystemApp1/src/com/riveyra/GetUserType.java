package com.riveyra;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetUserType {
	Connection conn = null;
	String str = null;
	PreparedStatement pstm = null;
	ResultSet rs = null;

	public String getUserType(String user_id) {
		// System.out.println("userId...." + user_id);
		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			// create the connection object
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "admin", "admin");
			pstm = conn.prepareStatement("Select * from user1" + " where userid=?");
			pstm.setInt(1, Integer.parseInt(user_id));
			rs = pstm.executeQuery();
			while (rs.next()) {
				str = rs.getString("user_type");
			}
		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
			str = "error";
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}

		finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstm != null) {
				try {
					pstm.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return str;
	}

}