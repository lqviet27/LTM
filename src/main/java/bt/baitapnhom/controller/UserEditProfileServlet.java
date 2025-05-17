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

@WebServlet("/user/edit-profile")
public class UserEditProfileServlet extends HttpServlet {
    private final UserBO userBO = new UserBO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra người dùng đã đăng nhập chưa
        HttpSession session = req.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Chuyển thông tin user sang trang edit_profile.jsp
        req.setAttribute("user", loggedInUser);
        req.getRequestDispatcher("/pages/user/edit_profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra người dùng đã đăng nhập chưa
        HttpSession session = req.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin từ form
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String mobilePhone = req.getParameter("mobilePhone");
        String address = req.getParameter("address");
        String currentJob = req.getParameter("currentJob");
        String currentPosition = req.getParameter("currentPosition");
        String otherInfo = req.getParameter("otherInfo");

        // Cập nhật thông tin user
        loggedInUser.setFullName(fullName);
        loggedInUser.setEmail(email);
        loggedInUser.setMobilePhone(mobilePhone);
        loggedInUser.setAddress(address);
        loggedInUser.setCurrentJob(currentJob);
        loggedInUser.setCurrentPosition(currentPosition);
        loggedInUser.setOtherInfo(otherInfo);

        // Lưu thông tin vào database
        boolean updated = userBO.updateUser(loggedInUser);

        if (updated) {
            // Cập nhật thông tin trong session
            session.setAttribute("user", loggedInUser);
            
            // Chuyển hướng về trang profile với thông báo thành công
            resp.sendRedirect(req.getContextPath() + "/user/profile?success=true");
        } else {
            // Chuyển hướng về trang edit profile với thông báo lỗi
            req.setAttribute("error", "Không thể cập nhật thông tin. Vui lòng thử lại.");
            req.setAttribute("user", loggedInUser);
            req.getRequestDispatcher("/pages/user/edit_profile.jsp").forward(req, resp);
        }
    }
} 