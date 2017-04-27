package csai;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn {
	public static Connection createDBConn () {
		try {
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/bigd","root","3er4#ER$");
			return conn;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static void closeConn(Connection conn) {
		try {
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
