package bt.baitapnhom.controller;

import bt.baitapnhom.model.bean.User;
import bt.baitapnhom.model.bo.UserBO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MemberListServlet", value = "/members")
public class MemberListServlet extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy danh sách tất cả thành viên từ database
            List<User> memberList = userBO.getAllUsers();
            
            // Đưa danh sách vào request attribute để JSP có thể truy cập
            request.setAttribute("memberList", memberList);
            
            // Forward request đến trang JSP
            request.getRequestDispatcher("/pages/members.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Có lỗi xảy ra: " + e.getMessage());
        }
    }
} 