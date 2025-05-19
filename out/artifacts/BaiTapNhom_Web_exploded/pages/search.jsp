<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bt.baitapnhom.model.bean.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Tìm kiếm thành viên</title>
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
        <h1 class="page-title">Tìm Kiếm Thành Viên</h1>
        
        <section class="search-form">
            <form action="${pageContext.request.contextPath}/search" method="GET">
                <input type="text" name="keyword" placeholder="Nhập tên thành viên hoặc vị trí..." 
                    value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>" required>
                <button type="submit">Tìm kiếm</button>
            </form>
        </section>
        
        <!-- Phần này sẽ hiển thị kết quả tìm kiếm khi người dùng thực hiện tìm kiếm -->
        <section class="intro-section">
            <h2>Kết quả tìm kiếm</h2>
            
            <% 
                Boolean hasSearched = (Boolean) request.getAttribute("hasSearched");
                if (hasSearched != null && hasSearched) {
                    List<User> searchResults = (List<User>) request.getAttribute("searchResults");
                    String keyword = (String) request.getAttribute("keyword");
                    
                    if (searchResults == null || searchResults.isEmpty()) {
            %>
                <p>Không tìm thấy kết quả nào cho từ khóa: <strong><%= keyword %></strong></p>
            <% 
                    } else {
            %>
                <p>Tìm thấy <%= searchResults.size() %> kết quả cho từ khóa: <strong><%= keyword %></strong></p>
                
                <div class="member-list" id="search-results">
                <% 
                    for(User member : searchResults) {
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
                %>
                </div>
            <% 
                    }
                } else {
            %>
                <p id="no-results">Hãy nhập từ khóa để tìm kiếm thành viên.</p>
            <% 
                }
            %>
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