package bt.baitapnhom.controller;

import bt.baitapnhom.common.Gender;
import bt.baitapnhom.common.UserRole;
import bt.baitapnhom.model.bean.User;
import bt.baitapnhom.model.bo.UserBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/admin/edit-member")
public class AdminEditMemberServlet extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra quyền admin
        HttpSession session = req.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy ID thành viên cần sửa
        String userId = req.getParameter("id");
        if (userId == null || userId.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/members?error=invalid_id");
            return;
        }

        try {
            int id = Integer.parseInt(userId);
            User user = userBO.getUserById(id);

            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/members?error=user_not_found");
                return;
            }

            // Gửi thông tin user cần sửa đến JSP
            req.setAttribute("user", user);
            req.getRequestDispatcher("/pages/admin/edit_member.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/members?error=invalid_id_format");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra quyền admin
        HttpSession session = req.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy ID thành viên cần sửa
        String userIdStr = req.getParameter("userId");
        if (userIdStr == null || userIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/members?error=invalid_id");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            User existingUser = userBO.getUserById(userId);

            if (existingUser == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/members?error=user_not_found");
                return;
            }

            // Lấy thông tin từ form
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String genderStr = req.getParameter("gender");
            String roleStr = req.getParameter("role");
            String mobilePhone = req.getParameter("mobilePhone");
            String address = req.getParameter("address");
            String currentJob = req.getParameter("currentJob");
            String currentPosition = req.getParameter("currentPosition");
            String avatarUrl = req.getParameter("avatarUrl");
            String otherInfo = req.getParameter("otherInfo");

            // Kiểm tra nếu email mới khác email cũ và đã tồn tại
            if (!email.equals(existingUser.getEmail()) && userBO.checkEmailExists(email)) {
                req.setAttribute("error", "Email đã tồn tại");
                req.setAttribute("user", existingUser);
                req.getRequestDispatcher("/pages/admin/edit_member.jsp").forward(req, resp);
                return;
            }

            // Cập nhật thông tin người dùng
            existingUser.setFullName(fullName);
            existingUser.setEmail(email);
            existingUser.setGender(Gender.valueOf(genderStr));
            existingUser.setRole(UserRole.valueOf(roleStr));
            existingUser.setMobilePhone(mobilePhone);
            existingUser.setAddress(address);
            existingUser.setCurrentJob(currentJob);
            existingUser.setCurrentPosition(currentPosition);
            existingUser.setAvatarUrl(avatarUrl);
            existingUser.setOtherInfo(otherInfo);
            existingUser.setUpdatedAt(LocalDateTime.now());

            // Cập nhật mật khẩu nếu có
            String password = req.getParameter("password");
            if (password != null && !password.isEmpty()) {
                existingUser.setPassword(password);
            }

            // Cập nhật thành viên
            boolean success = userBO.updateUser(existingUser);

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin/members?success=updated");
            } else {
                req.setAttribute("error", "Không thể cập nhật thông tin. Vui lòng thử lại.");
                req.setAttribute("user", existingUser);
                req.getRequestDispatcher("/pages/admin/edit_member.jsp").forward(req, resp);
            }

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/members?error=invalid_id_format");
        }
    }
}
