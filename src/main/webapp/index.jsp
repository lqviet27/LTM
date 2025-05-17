<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Trang chủ</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="/pages/common/header.jsp" %>
    
    <main class="container">
        <h1 class="page-title">Giới Thiệu Nhóm</h1>
        
        <section class="intro-section">
            <h2>Chào mừng đến với Nhóm của chúng tôi</h2>
            <p>Chúng tôi là một nhóm sinh viên đam mê công nghệ thông tin, đặc biệt là lĩnh vực lập trình mạng. Nhóm được thành lập vào năm 2023 với mục tiêu nghiên cứu và phát triển các ứng dụng web hiện đại.</p>
            <p>Sứ mệnh của chúng tôi là tạo ra các giải pháp công nghệ đơn giản, hiệu quả và thân thiện với người dùng.</p>
            
            <h3>Thông tin sơ lược về các thành viên:</h3>
            <div class="member-list">
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
            </div>
            
            <div style="text-align: center; margin-top: 30px;">
                <a href="${pageContext.request.contextPath}/members" style="display: inline-block; padding: 10px 20px; background-color: #2c3e50; color: white; text-decoration: none; border-radius: 4px;">Xem tất cả thành viên</a>
            </div>
        </section>
    </main>
    
    <%@ include file="/pages/common/footer.jsp" %>
</body>
</html>