<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Tìm kiếm thành viên</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="/pages/common/header.jsp" %>
    
    <main class="container">
        <h1 class="page-title">Tìm Kiếm Thành Viên</h1>
        
        <section class="search-form">
            <form action="${pageContext.request.contextPath}/search" method="GET">
                <input type="text" name="keyword" placeholder="Nhập tên thành viên hoặc vị trí..." required>
                <button type="submit">Tìm kiếm</button>
            </form>
        </section>
        
        <!-- Phần này sẽ hiển thị kết quả tìm kiếm khi người dùng thực hiện tìm kiếm -->
        <section class="intro-section">
            <h2>Kết quả tìm kiếm</h2>
            
            <!-- Hiển thị thông báo nếu không có kết quả -->
            <p id="no-results" style="display: block;">Hãy nhập từ khóa để tìm kiếm thành viên.</p>
            
            <!-- Kết quả tìm kiếm sẽ được hiển thị ở đây -->
            <div class="member-list" id="search-results">
                <!-- Đây là ví dụ về kết quả, sẽ được thay thế bằng kết quả thực tế khi tìm kiếm -->
                <!--
                <div class="member-card">
                    <img src="https://via.placeholder.com/300x200" alt="Thành viên">
                    <div class="member-info">
                        <h3 class="member-name">Tên thành viên</h3>
                        <p class="member-position">Vị trí công việc</p>
                        <p class="member-description">Mô tả chi tiết về thành viên và trách nhiệm trong nhóm.</p>
                    </div>
                </div>
                -->
            </div>
        </section>
    </main>
    
    <%@ include file="/pages/common/footer.jsp" %>
    
    <!-- Script để xử lý form tìm kiếm -->
    <script>
        // JavaScript cơ bản để xử lý tìm kiếm sẽ được triển khai ở đây
        // Trong phiên bản hoàn chỉnh, sẽ cần xử lý AJAX để tìm kiếm không cần tải lại trang
        
        // Ví dụ đơn giản để hiển thị/ẩn thông báo khi form được submit
        document.querySelector('form').addEventListener('submit', function(e) {
            // Trong phiên bản thực tế, không cần preventDefault vì form sẽ gửi request đến server
            // e.preventDefault();
            
            document.getElementById('no-results').style.display = 'none';
            // Code để hiển thị kết quả tìm kiếm sẽ được triển khai sau
        });
    </script>
</body>
</html> 