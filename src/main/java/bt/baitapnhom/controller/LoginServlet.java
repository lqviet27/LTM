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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Hiển thị trang đăng nhập
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Kiểm tra đăng nhập
        User user = userBO.getUserByUsername(username);

        if (user != null && password.equals(user.getPassword())) {
            // Đăng nhập thành công - lưu thông tin user vào session
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("isLoggedIn", true);

            // Chuyển hướng đến trang thông tin người dùng
            resp.sendRedirect(req.getContextPath() + "/user/profile");
        } else {
            // Đăng nhập thất bại - chuyển hướng về trang đăng nhập với thông báo lỗi
            resp.sendRedirect(req.getContextPath() + "/login?error=true");
        }
    }
} 