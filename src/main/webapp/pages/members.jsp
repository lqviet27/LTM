<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Danh sách thành viên</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="/pages/common/header.jsp" %>
    
    <main class="container">
        <h1 class="page-title">Danh Sách Thành Viên</h1>
        
        <section class="intro-section">
            <p>Dưới đây là danh sách đầy đủ các thành viên trong nhóm của chúng tôi. Mỗi thành viên đều có vai trò và trách nhiệm riêng, cùng đóng góp vào sự phát triển chung của dự án.</p>
            
            <div class="member-list">
                <div class="member-card">
                    <img src="https://via.placeholder.com/300x200" alt="Thành viên 1">
                    <div class="member-info">
                        <h3 class="member-name">Nguyễn Văn A</h3>
                        <p class="member-position">Trưởng nhóm</p>
                        <p class="member-description">Chuyên về phát triển backend và quản lý dự án. Có 5 năm kinh nghiệm làm việc với Java và các framework web.</p>
                    </div>
                </div>
                
                <div class="member-card">
                    <img src="https://via.placeholder.com/300x200" alt="Thành viên 2">
                    <div class="member-info">
                        <h3 class="member-name">Trần Thị B</h3>
                        <p class="member-position">Frontend Developer</p>
                        <p class="member-description">Chuyên về thiết kế giao diện và trải nghiệm người dùng. Thành thạo HTML, CSS, JavaScript và các framework frontend hiện đại.</p>
                    </div>
                </div>
                
                <div class="member-card">
                    <img src="https://via.placeholder.com/300x200" alt="Thành viên 3">
                    <div class="member-info">
                        <h3 class="member-name">Lê Văn C</h3>
                        <p class="member-position">Database Engineer</p>
                        <p class="member-description">Chuyên về thiết kế và tối ưu hóa cơ sở dữ liệu. Có kinh nghiệm làm việc với MySQL, PostgreSQL và MongoDB.</p>
                    </div>
                </div>
                
                <div class="member-card">
                    <img src="https://via.placeholder.com/300x200" alt="Thành viên 4">
                    <div class="member-info">
                        <h3 class="member-name">Phạm Thị D</h3>
                        <p class="member-position">QA Engineer</p>
                        <p class="member-description">Chịu trách nhiệm kiểm thử và đảm bảo chất lượng phần mềm. Thành thạo các công cụ kiểm thử tự động và thủ công.</p>
                    </div>
                </div>
                
                <div class="member-card">
                    <img src="https://via.placeholder.com/300x200" alt="Thành viên 5">
                    <div class="member-info">
                        <h3 class="member-name">Hoàng Văn E</h3>
                        <p class="member-position">DevOps Engineer</p>
                        <p class="member-description">Phụ trách triển khai và duy trì hệ thống. Có kinh nghiệm với Docker, Kubernetes và các công cụ CI/CD.</p>
                    </div>
                </div>
                
                <div class="member-card">
                    <img src="https://via.placeholder.com/300x200" alt="Thành viên 6">
                    <div class="member-info">
                        <h3 class="member-name">Vũ Thị F</h3>
                        <p class="member-position">UI/UX Designer</p>
                        <p class="member-description">Thiết kế giao diện người dùng và trải nghiệm người dùng. Thành thạo các công cụ thiết kế như Figma, Adobe XD.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <%@ include file="/pages/common/footer.jsp" %>
</body>
</html> 