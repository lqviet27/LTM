<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bt.baitapnhom.model.bean.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Danh sách thành viên</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header>
        <div class="container header-container">
            <div class="logo">
                <h1>Quản Lý Nhóm</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/members">Thành viên</a></li>
                    <li><a href="${pageContext.request.contextPath}/search">Tìm kiếm</a></li>
                </ul>
            </nav>
            <div class="auth-buttons">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Đăng nhập</a>
            </div>
        </div>
    </header>
    
    <main class="container">
        <h1 class="page-title">Danh Sách Thành Viên</h1>
        
        <section class="intro-section">
            <p>Dưới đây là danh sách đầy đủ các thành viên trong nhóm của chúng tôi. Mỗi thành viên đều có vai trò và trách nhiệm riêng, cùng đóng góp vào sự phát triển chung của dự án.</p>
            
            <div class="member-list">
                <% 
                    List<User> memberList = (List<User>) request.getAttribute("memberList");
                    if(memberList != null && !memberList.isEmpty()) {
                        for(User member : memberList) {
                %>
                    <div class="member-card">
                        <img src="<%= member.getAvatarUrl() != null && !member.getAvatarUrl().isEmpty() ? member.getAvatarUrl() : "https://via.placeholder.com/300x200" %>" 
                             alt="<%= member.getFullName() %>">
                        <div class="member-info">
                            <h3 class="member-name"><%= member.getFullName() %></h3>
                            <p class="member-position"><%= member.getCurrentPosition() != null ? member.getCurrentPosition() : "Thành viên" %></p>
                            <p class="member-description">
                                <%= member.getCurrentJob() != null && !member.getCurrentJob().isEmpty() ? member.getCurrentJob() : "Thành viên nhóm" %>
                                <%= member.getOtherInfo() != null && !member.getOtherInfo().isEmpty() ? ". " + member.getOtherInfo() : "" %>
                            </p>
                        </div>
                    </div>
                <% 
                        }
                    } else {
                %>
                    <p style="text-align: center; margin: 30px 0;">Không có thành viên nào trong cơ sở dữ liệu.</p>
                <% } %>
            </div>
        </section>
    </main>
    
    <footer>
        <div class="container">
            <div class="footer-content">
                <p>&copy; 2023 - Quản Lý Nhóm</p>
                <p>Đại học Việt Nam</p>
                <p>Email: lienhe@example.com</p>
                <div class="social-links">
                    <a href="#" target="_blank">Facebook</a>
                    <a href="#" target="_blank">Twitter</a>
                    <a href="#" target="_blank">Instagram</a>
                </div>
            </div>
        </div>
    </footer>
</body>
</html> 