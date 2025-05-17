package bt.baitapnhom.filter;

import bt.baitapnhom.common.UserRole;
import bt.baitapnhom.model.bean.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/admin/*", "/profile"})
public class AuthenticationFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        
        // Kiểm tra xem người dùng đã đăng nhập chưa
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        User user = isLoggedIn ? (User) session.getAttribute("user") : null;
        
        if (isLoggedIn) {
            // Đã đăng nhập, kiểm tra quyền truy cập
            if (requestURI.startsWith(httpRequest.getContextPath() + "/admin/")) {
                // Yêu cầu truy cập trang admin
                if (user.getRole() == UserRole.ADMIN) {
                    // Người dùng có quyền admin, cho phép truy cập
                    chain.doFilter(request, response);
                } else {
                    // Không có quyền admin, chuyển hướng đến trang thông báo lỗi
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/access-denied");
                }
            } else {
                // Yêu cầu truy cập các trang khác cần đăng nhập (như trang profile)
                chain.doFilter(request, response);
            }
        } else {
            // Chưa đăng nhập, chuyển hướng đến trang đăng nhập
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // Cleanup code
    }
} 