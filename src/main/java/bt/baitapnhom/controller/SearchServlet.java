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

@WebServlet(name = "SearchServlet", value = "/search")
public class SearchServlet extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String keyword = request.getParameter("keyword");
            
            // Nếu có từ khóa tìm kiếm
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Tìm kiếm users từ cơ sở dữ liệu
                List<User> searchResults = userBO.searchUsers(keyword);
                request.setAttribute("searchResults", searchResults);
                request.setAttribute("keyword", keyword);
                request.setAttribute("hasSearched", true);
            } else {
                // Nếu không có từ khóa, hiển thị form tìm kiếm
                request.setAttribute("hasSearched", false);
            }
            
            // Chuyển đến trang JSP tìm kiếm
            request.getRequestDispatcher("/pages/search.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Có lỗi xảy ra: " + e.getMessage());
        }
    }
} 