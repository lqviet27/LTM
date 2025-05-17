package bt.baitapnhom.model.bo;

import bt.baitapnhom.model.dao.UserDAO;
import bt.baitapnhom.model.bean.User;

import java.util.List;

public class UserBO {
    private final UserDAO userDAO = new UserDAO();

    /**
     * Thêm một người dùng mới vào hệ thống.
     * @param user Đối tượng User chứa thông tin người dùng.
     * @return true nếu thêm thành công, false nếu thất bại.
     */
    public boolean addUser(User user) {
        // Có thể thêm logic kiểm tra trước khi thêm vào CSDL, ví dụ: kiểm tra mật khẩu đủ mạnh
        return userDAO.addUser(user);
    }

    /**
     * Lấy thông tin người dùng bằng username.
     * @param username Tên đăng nhập.
     * @return Đối tượng User nếu tìm thấy, null nếu không tìm thấy.
     */
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }

    /**
     * Lấy thông tin người dùng bằng user_id.
     * @param userId ID của người dùng.
     * @return Đối tượng User nếu tìm thấy, null nếu không tìm thấy.
     */
    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    /**
     * Lấy danh sách tất cả người dùng.
     * @return Danh sách các đối tượng User.
     */
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    /**
     * Cập nhật thông tin người dùng.
     * @param user Đối tượng User chứa thông tin cần cập nhật.
     * @return true nếu cập nhật thành công, false nếu thất bại.
     */
    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }

    /**
     * Xóa người dùng khỏi hệ thống.
     * @param userId ID của người dùng cần xóa.
     * @return true nếu xóa thành công, false nếu thất bại.
     */
    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }

    /**
     * Kiểm tra username đã tồn tại hay chưa.
     * @param username Tên đăng nhập cần kiểm tra.
     * @return true nếu username đã tồn tại, false nếu chưa tồn tại.
     */
    public boolean checkUsernameExists(String username) {
        return userDAO.checkUsernameExists(username);
    }

    /**
     * Kiểm tra email đã tồn tại hay chưa.
     * @param email Địa chỉ email cần kiểm tra.
     * @return true nếu email đã tồn tại, false nếu chưa tồn tại.
     */
    public boolean checkEmailExists(String email) {
        return userDAO.checkEmailExists(email);
    }

    /**
     * Tìm kiếm người dùng dựa trên từ khóa.
     * @param keyword Từ khóa tìm kiếm.
     * @return Danh sách các User phù hợp.
     */
    public List<User> searchUsers(String keyword) {
        return userDAO.searchUsers(keyword);
    }
}
