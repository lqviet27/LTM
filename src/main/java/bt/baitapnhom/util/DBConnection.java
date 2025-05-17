package bt.baitapnhom.util;

import java.sql.*;

public class DBConnection {
    private static final String URL = "jdbc:mysql://pbl-db.mysql.database.azure.com:3306/ltm?useUnicode=true&characterEncoding=UTF-8";
    private static final String USERNAME = "lqv";
    private static final String PASSWORD = "123qwe!@#";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    // Phương thức để lấy kết nối đến CSDL
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Bước 1: Đăng ký JDBC driver
            Class.forName(DRIVER);

            // Bước 2: Mở một kết nối
            System.out.println("Connecting to database..."); // Dòng này để debug, có thể xóa sau
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Connected database successfully..."); // Dòng này để debug

        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Connection Failed! Check output console: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }

    // Phương thức tiện ích để đóng các tài nguyên (Connection, PreparedStatement, ResultSet)
    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("Error closing ResultSet: " + e.getMessage());
        }
        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            System.err.println("Error closing PreparedStatement: " + e.getMessage());
        }
        try {
            if (conn != null) {
                conn.close();
                System.out.println("Database connection closed."); // Dòng này để debug
            }
        } catch (SQLException e) {
            System.err.println("Error closing Connection: " + e.getMessage());
        }
    }

    // Overload phương thức close nếu không dùng ResultSet
    public static void close(Connection conn, PreparedStatement pstmt) {
        close(conn, pstmt, null);
    }
}
