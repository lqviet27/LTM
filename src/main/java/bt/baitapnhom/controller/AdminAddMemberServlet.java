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

@WebServlet("/admin/add-member")
public class AdminAddMemberServlet extends HttpServlet {
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

        // Hiển thị form thêm thành viên
        req.getRequestDispatcher("/pages/admin/add_member.jsp").forward(req, resp);
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

        // Lấy thông tin từ form
        String username = req.getParameter("username");
        String password = req.getParameter("password");
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

        // Kiểm tra username và email đã tồn tại chưa
        if (userBO.checkUsernameExists(username)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại");
            req.getRequestDispatcher("/pages/admin/add_member.jsp").forward(req, resp);
            return;
        }

        if (userBO.checkEmailExists(email)) {
            req.setAttribute("error", "Email đã tồn tại");
            req.getRequestDispatcher("/pages/admin/add_member.jsp").forward(req, resp);
            return;
        }

        // Tạo đối tượng User mới
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setFullName(fullName);
        newUser.setEmail(email);
        newUser.setGender(Gender.valueOf(genderStr));
        newUser.setRole(UserRole.valueOf(roleStr));
        newUser.setMobilePhone(mobilePhone);
        newUser.setAddress(address);
        newUser.setCurrentJob(currentJob);
        newUser.setCurrentPosition(currentPosition);
        newUser.setAvatarUrl(avatarUrl);
        newUser.setOtherInfo(otherInfo);
        newUser.setCreatedAt(LocalDateTime.now());
        newUser.setUpdatedAt(LocalDateTime.now());

        // Thêm user mới
        boolean success = userBO.addUser(newUser);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/members?success=added");
        } else {
            req.setAttribute("error", "Không thể thêm thành viên. Vui lòng thử lại.");
            req.getRequestDispatcher("/pages/admin/add_member.jsp").forward(req, resp);
        }
    }
}
