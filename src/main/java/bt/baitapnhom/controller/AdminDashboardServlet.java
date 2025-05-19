package bt.baitapnhom.controller;

import bt.baitapnhom.common.UserRole;
import bt.baitapnhom.model.bean.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý trang chủ của phần Admin
 */
@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra quyền admin
        HttpSession session = req.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        if (loggedInUser == null || loggedInUser.getRole() != UserRole.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        // Chuyển hướng đến trang quản lý thành viên (có thể thay đổi về sau nếu cần)
        resp.sendRedirect(req.getContextPath() + "/admin/members");
    }
}
