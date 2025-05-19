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

@WebServlet("/admin/view-member")
public class AdminViewMemberServlet extends HttpServlet {
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

        // Lấy ID thành viên cần xem
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/members?error=invalid_id");
            return;
        }
        
        try {
            int userId = Integer.parseInt(idStr);
            User user = userBO.getUserById(userId);
            
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/members?error=user_not_found");
                return;
            }
            
            // Gửi thông tin user đến JSP
            req.setAttribute("viewUser", user);
            req.getRequestDispatcher("/pages/admin/view_member.jsp").forward(req, resp);
            
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/members?error=invalid_id_format");
        }
    }
}
