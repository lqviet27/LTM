package bt.baitapnhom.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session hiện tại nếu tồn tại
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Xóa thuộc tính user khỏi session
            session.removeAttribute("user");
            
            // Hủy session
            session.invalidate();
        }
        
        // Chuyển hướng về trang chủ
        response.sendRedirect(request.getContextPath() + "/");
    }
} 