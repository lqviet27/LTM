<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bt.baitapnhom.model.bean.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Trang chủ</title>
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
        <h1 class="page-title">Giới Thiệu Nhóm</h1>
        
        <section class="intro-section">
            <h2>Chào mừng đến với Nhóm của chúng tôi</h2>
            <p>Chúng tôi là một nhóm sinh viên đam mê công nghệ thông tin, đặc biệt là lĩnh vực lập trình mạng. Nhóm được thành lập vào năm 2023 với mục tiêu nghiên cứu và phát triển các ứng dụng web hiện đại.</p>
            <p>Sứ mệnh của chúng tôi là tạo ra các giải pháp công nghệ đơn giản, hiệu quả và thân thiện với người dùng.</p>
            
            <h3>Thông tin sơ lược về các thành viên:</h3>
            <div class="member-list">
                <% 
                    List<User> featuredMembers = (List<User>) request.getAttribute("featuredMembers");
                    if(featuredMembers != null && !featuredMembers.isEmpty()) {
                        for(User member : featuredMembers) {
                %>
                    <div class="member-card">
                        <img src="<%= member.getAvatarUrl() != null && !member.getAvatarUrl().isEmpty() ? member.getAvatarUrl() : "https://via.placeholder.com/300x200" %>" 
                             alt="<%= member.getFullName() %>">
                        <div class="member-info">
                            <h3 class="member-name"><%= member.getFullName() %></h3>
                            <p class="member-position"><%= member.getCurrentPosition() != null ? member.getCurrentPosition() : "Thành viên" %></p>
                            <p class="member-description">
                                <%= member.getCurrentJob() != null && !member.getCurrentJob().isEmpty() ? member.getCurrentJob() : "Thành viên nhóm" %>
                            </p>
                        </div>
                    </div>
                <% 
                        }
                    } else {
                %>
                    <!-- Hiển thị dữ liệu mẫu nếu database không có dữ liệu -->
                    <div class="member-card">
                        <img src="https://via.placeholder.com/300x200" alt="Thành viên 1">
                        <div class="member-info">
                            <h3 class="member-name">Nguyễn Văn A</h3>
                            <p class="member-position">Trưởng nhóm</p>
                            <p class="member-description">Chuyên về phát triển backend và quản lý dự án.</p>
                        </div>
                    </div>
                    
                    <div class="member-card">
                        <img src="https://via.placeholder.com/300x200" alt="Thành viên 2">
                        <div class="member-info">
                            <h3 class="member-name">Trần Thị B</h3>
                            <p class="member-position">Frontend Developer</p>
                            <p class="member-description">Chuyên về thiết kế giao diện và trải nghiệm người dùng.</p>
                        </div>
                    </div>
                    
                    <div class="member-card">
                        <img src="https://via.placeholder.com/300x200" alt="Thành viên 3">
                        <div class="member-info">
                            <h3 class="member-name">Lê Văn C</h3>
                            <p class="member-position">Database Engineer</p>
                            <p class="member-description">Chuyên về thiết kế và tối ưu hóa cơ sở dữ liệu.</p>
                        </div>
                    </div>
                <% } %>
            </div>
            
            <div style="text-align: center; margin-top: 30px;">
                <a href="${pageContext.request.contextPath}/members" style="display: inline-block; padding: 10px 20px; background-color: #2c3e50; color: white; text-decoration: none; border-radius: 4px;">Xem tất cả thành viên</a>
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