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

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hiển thị form đăng nhập
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Kiểm tra đăng nhập
        User user = userBO.getUserByUsername(username);
        
        if (user != null && password.equals(user.getPassword())) {
            // Đăng nhập thành công - lưu vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Chuyển hướng đến trang chủ
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            // Đăng nhập thất bại
            response.sendRedirect(request.getContextPath() + "/login?error=true");
        }
    }
} 