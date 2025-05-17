<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Thông tin người dùng</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .profile-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 20px;
        }
        
        .profile-header-info h1 {
            margin: 0 0 10px 0;
        }
        
        .profile-section {
            margin-bottom: 30px;
        }
        
        .profile-section h2 {
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        
        .profile-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .info-item {
            margin-bottom: 15px;
        }
        
        .info-label {
            font-weight: 500;
            margin-bottom: 5px;
            color: #666;
        }
        
        .info-value {
            font-size: 16px;
        }
        
        .profile-actions {
            margin-top: 20px;
            text-align: right;
        }
        
        .btn-edit {
            padding: 10px 15px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-edit:hover {
            background-color: #34495e;
        }
        
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            display: none;
        }
    </style>
</head>
<body>
    <%@ include file="/pages/common/header.jsp" %>
    
    <main class="container">
        <div class="profile-container">
            <div id="success-message" class="success-message">
                Thông tin đã được cập nhật thành công!
            </div>
            
            <div class="profile-header">
                <img src="${user.avatarUrl != null ? user.avatarUrl : pageContext.request.contextPath.concat('/img/default-avatar.jpg')}" alt="Avatar" class="avatar">
                <div class="profile-header-info">
                    <h1>${user.fullName}</h1>
                    <p>${user.currentJob} ${user.currentPosition != null ? '- '.concat(user.currentPosition) : ''}</p>
                </div>
            </div>
            
            <div class="profile-section">
                <h2>Thông tin cá nhân</h2>
                <div class="profile-info">
                    <div class="info-item">
                        <div class="info-label">Họ và tên</div>
                        <div class="info-value">${user.fullName}</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Email</div>
                        <div class="info-value">${user.email}</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Số điện thoại</div>
                        <div class="info-value">${user.mobilePhone != null ? user.mobilePhone : 'Chưa cập nhật'}</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Địa chỉ</div>
                        <div class="info-value">${user.address != null ? user.address : 'Chưa cập nhật'}</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Công việc hiện tại</div>
                        <div class="info-value">${user.currentJob != null ? user.currentJob : 'Chưa cập nhật'}</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Chức vụ hiện tại</div>
                        <div class="info-value">${user.currentPosition != null ? user.currentPosition : 'Chưa cập nhật'}</div>
                    </div>
                </div>
            </div>
            
            <div class="profile-section">
                <h2>Thông tin khác</h2>
                <div class="info-value">
                    ${user.otherInfo != null ? user.otherInfo : 'Không có thông tin'}
                </div>
            </div>
            
            <div class="profile-actions">
                <a href="${pageContext.request.contextPath}/user/edit-profile" class="btn-edit">Chỉnh sửa thông tin</a>
            </div>
        </div>
    </main>
    
    <%@ include file="/pages/common/footer.jsp" %>
    
    <script>
        // Hiển thị thông báo thành công nếu có
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('success') === 'true') {
            document.getElementById('success-message').style.display = 'block';
            
            // Ẩn thông báo sau 5 giây
            setTimeout(() => {
                document.getElementById('success-message').style.display = 'none';
            }, 5000);
        }
    </script>
</body>
</html> 