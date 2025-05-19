package bt.baitapnhom.controller;

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
import java.util.List;

@WebServlet("/admin/members")
public class AdminMembersServlet extends HttpServlet {
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

        // Lấy danh sách tất cả thành viên
        List<User> members = userBO.getAllUsers();
        req.setAttribute("members", members);
        
        // Hiển thị trang quản lý thành viên
        req.getRequestDispatcher("/pages/admin/members.jsp").forward(req, resp);
    }
}
