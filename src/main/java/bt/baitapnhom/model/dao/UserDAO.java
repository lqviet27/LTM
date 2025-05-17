package bt.baitapnhom.model.dao;

import bt.baitapnhom.common.Gender;
import bt.baitapnhom.common.UserRole;
import bt.baitapnhom.model.bean.User;
import bt.baitapnhom.util.DBConnection;

import javax.management.relation.Role;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    /**
     * Thêm một người dùng mới vào CSDL.
     * MẬT KHẨU SẼ ĐƯỢC LƯU TRỰC TIẾP (KHÔNG MÃ HÓA).
     * Vai trò mặc định sẽ là 'user' nếu không được cung cấp hoặc null.
     * @param user Đối tượng User chứa thông tin người dùng mới.
     * @return true nếu thêm thành công, false nếu thất bại (ví dụ: username/email đã tồn tại, lỗi CSDL).
     */
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, password, full_name, email, role, mobile_phone, address, current_job, current_position, avatar_url, other_info) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean rowInserted = false;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("addUser: Database connection is null.");
                return false;
            }
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword()); // Lưu mật khẩu trực tiếp
            pstmt.setString(3, user.getFullName());
            pstmt.setString(4, user.getEmail());

            // Xử lý role: nếu null hoặc rỗng, dùng giá trị mặc định 'user' của CSDL
            // Hoặc nếu muốn chắc chắn từ Java:
            UserRole role = user.getRole();
            if (role == null || (!role.equals(UserRole.USER) && !role.equals(UserRole.ADMIN))) {
                role = UserRole.USER; // Đảm bảo giá trị hợp lệ hoặc để CSDL tự xử lý default
            }
            pstmt.setString(5, role.toString());

            pstmt.setString(6, user.getMobilePhone());
            pstmt.setString(7, user.getAddress());
            pstmt.setString(8, user.getCurrentJob());
            pstmt.setString(9, user.getCurrentPosition());
            pstmt.setString(10, user.getAvatarUrl());
            pstmt.setString(11, user.getOtherInfo());

            rowInserted = pstmt.executeUpdate() > 0;

        } catch (SQLIntegrityConstraintViolationException e) {
            // Lỗi này thường xảy ra do vi phạm ràng buộc UNIQUE (username hoặc email đã tồn tại)
            System.err.println("addUser Error: Username or Email already exists. " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("addUser SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt);
        }
        return rowInserted;
    }

    /**
     * Lấy thông tin người dùng bằng username.
     * @param username Tên đăng nhập của người dùng.
     * @return Đối tượng User nếu tìm thấy, null nếu không tìm thấy hoặc có lỗi.
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("getUserByUsername: Database connection is null.");
                return null;
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            System.err.println("getUserByUsername SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }
        return user;
    }

    /**
     * Lấy thông tin người dùng bằng user_id.
     * @param userId ID của người dùng.
     * @return Đối tượng User nếu tìm thấy, null nếu không tìm thấy hoặc có lỗi.
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("getUserById: Database connection is null.");
                return null;
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            System.err.println("getUserById SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }
        return user;
    }

    /**
     * Lấy danh sách tất cả người dùng.
     * @return Danh sách các đối tượng User, có thể rỗng nếu không có user nào hoặc có lỗi.
     */
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY user_id ASC"; // Sắp xếp để có thứ tự nhất quán
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("getAllUsers: Database connection is null.");
                return userList; // Trả về danh sách rỗng
            }
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                userList.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("getAllUsers SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }
        return userList;
    }

    /**
     * Cập nhật thông tin người dùng.
     * Mật khẩu có thể được cập nhật trực tiếp nếu người dùng thay đổi.
     * @param user Đối tượng User chứa thông tin cần cập nhật (phải có user_id).
     * @return true nếu cập nhật thành công, false nếu thất bại.
     */
    public boolean updateUser(User user) {
        StringBuilder sqlBuilder = new StringBuilder("UPDATE users SET full_name = ?, email = ?, mobile_phone = ?, address = ?, current_job = ?, current_position = ?, role = ?, avatar_url = ?, other_info = ?");
        // Chỉ cập nhật mật khẩu nếu nó được cung cấp (không null và không rỗng)
        boolean updatePassword = (user.getPassword() != null && !user.getPassword().isEmpty());
        if (updatePassword) {
            sqlBuilder.append(", password = ?");
        }
        sqlBuilder.append(" WHERE user_id = ?");

        String sql = sqlBuilder.toString();
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean rowUpdated = false;
        int parameterIndex = 1;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("updateUser: Database connection is null.");
                return false;
            }
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(parameterIndex++, user.getFullName());
            pstmt.setString(parameterIndex++, user.getEmail());
            pstmt.setString(parameterIndex++, user.getMobilePhone());
            pstmt.setString(parameterIndex++, user.getAddress());
            pstmt.setString(parameterIndex++, user.getCurrentJob());
            pstmt.setString(parameterIndex++, user.getCurrentPosition());

            UserRole role = user.getRole();
            if (role == null || (!role.equals(UserRole.USER) && !role.equals(UserRole.ADMIN))) {
                role = UserRole.USER; // Đảm bảo giá trị hợp lệ
            }
            pstmt.setString(parameterIndex++, role.toString());

            pstmt.setString(parameterIndex++, user.getAvatarUrl());
            pstmt.setString(parameterIndex++, user.getOtherInfo());

            if (updatePassword) {
                pstmt.setString(parameterIndex++, user.getPassword()); // Cập nhật mật khẩu plain text
            }
            pstmt.setInt(parameterIndex++, user.getUserId());

            rowUpdated = pstmt.executeUpdate() > 0;

        } catch (SQLIntegrityConstraintViolationException e) {
            System.err.println("updateUser Error: Email might already exist for another user. " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("updateUser SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt);
        }
        return rowUpdated;
    }

    /**
     * Xóa người dùng khỏi CSDL dựa trên user_id.
     * @param userId ID của người dùng cần xóa.
     * @return true nếu xóa thành công, false nếu thất bại.
     */
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean rowDeleted = false;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("deleteUser: Database connection is null.");
                return false;
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rowDeleted = pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("deleteUser SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt);
        }
        return rowDeleted;
    }

    /**
     * Kiểm tra xem username đã tồn tại trong CSDL chưa.
     * @param username Tên đăng nhập cần kiểm tra.
     * @return true nếu username đã tồn tại, false nếu chưa tồn tại hoặc có lỗi.
     */
    public boolean checkUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("checkUsernameExists: Database connection is null.");
                return true; // Giả định là có lỗi, không cho đăng ký để tránh trùng lặp không kiểm soát
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("checkUsernameExists SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }
        return false; // Mặc định là chưa tồn tại nếu không có lỗi và không tìm thấy.
    }

    /**
     * Kiểm tra xem email đã tồn tại trong CSDL chưa.
     * @param email Email cần kiểm tra.
     * @return true nếu email đã tồn tại, false nếu chưa tồn tại hoặc có lỗi.
     */
    public boolean checkEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("checkEmailExists: Database connection is null.");
                return true; // Giả sử là có lỗi, không cho đăng ký
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("checkEmailExists SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }
        return false;
    }

    /**
     * Tìm kiếm người dùng dựa trên từ khóa (full_name hoặc email).
     * @param keyword Từ khóa tìm kiếm.
     * @return Danh sách các User phù hợp.
     */
    public List<User> searchUsers(String keyword) {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE full_name LIKE ? OR email LIKE ? ORDER BY full_name ASC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("searchUsers: Database connection is null.");
                return userList;
            }
            pstmt = conn.prepareStatement(sql);
            String searchKeyword = "%" + keyword + "%";
            pstmt.setString(1, searchKeyword);
            pstmt.setString(2, searchKeyword);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                userList.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("searchUsers SQL Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }
        return userList;
    }


    /**
     * Phương thức private tiện ích để map một dòng ResultSet thành một đối tượng User.
     * @param rs ResultSet đang trỏ đến một dòng dữ liệu user.
     * @return Đối tượng User.
     * @throws SQLException Nếu có lỗi khi truy cập ResultSet.
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password")); // Lấy mật khẩu (đã lưu trực tiếp)
        user.setFullName(rs.getString("full_name"));
        user.setGender(Gender.valueOf(rs.getString("gender")));
        user.setEmail(rs.getString("email"));
        user.setMobilePhone(rs.getString("mobile_phone"));
        user.setAddress(rs.getString("address"));
        user.setCurrentJob(rs.getString("current_job"));
        user.setCurrentPosition(rs.getString("current_position"));
        user.setRole(UserRole.valueOf(rs.getString("role")));
        user.setAvatarUrl(rs.getString("avatar_url"));
        user.setOtherInfo(rs.getString("other_info"));

        // Chuyển đổi java.sql.Timestamp từ DB sang java.time.LocalDateTime
        Timestamp createdAtTimestamp = rs.getTimestamp("created_at");
        if (createdAtTimestamp != null) {
            user.setCreatedAt(createdAtTimestamp.toLocalDateTime());
        } else {
            user.setCreatedAt(null); // Hoặc một giá trị mặc định nếu cần
        }

        Timestamp updatedAtTimestamp = rs.getTimestamp("updated_at");
        if (updatedAtTimestamp != null) {
            user.setUpdatedAt(updatedAtTimestamp.toLocalDateTime());
        } else {
            user.setUpdatedAt(null); // Hoặc một giá trị mặc định nếu cần
        }

        return user;
    }
}

