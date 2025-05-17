package bt.baitapnhom.controller;

import bt.baitapnhom.model.bean.User;
import bt.baitapnhom.model.bo.UserBO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "IndexServlet", value = "/home")
public class IndexServlet extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy danh sách tất cả thành viên từ database
            List<User> allMembers = userBO.getAllUsers();
            
            // Lấy 3 thành viên đầu tiên cho trang chủ (nếu có)
            List<User> featuredMembers = allMembers.stream()
                    .limit(3)
                    .collect(Collectors.toList());
            
            // Đưa danh sách vào request attribute để JSP có thể truy cập
            request.setAttribute("featuredMembers", featuredMembers);
            
            // Forward request đến trang JSP
            request.getRequestDispatcher("/pages/home.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Có lỗi xảy ra: " + e.getMessage());
        }
    }
} 