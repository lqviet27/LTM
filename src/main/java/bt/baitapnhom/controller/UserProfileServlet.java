package bt.baitapnhom.controller;

import bt.baitapnhom.model.bean.User;
import bt.baitapnhom.model.bo.UserBO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/profile")
public class UserProfileServlet extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra xem người dùng đã đăng nhập chưa
        HttpSession session = req.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            // Nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Chuyển dữ liệu user sang trang profile.jsp
        req.setAttribute("user", loggedInUser);
        req.getRequestDispatcher("/pages/user/profile.jsp").forward(req, resp);
    }
} 