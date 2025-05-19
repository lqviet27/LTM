<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Chi tiết thành viên</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .admin-container {
            max-width: 800px;
            margin: 40px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .member-info {
            margin-bottom: 30px;
        }
        
        .member-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            gap: 20px;
        }
        
        .member-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #2c3e50;
        }
        
        .member-avatar-placeholder {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #95a5a6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
            color: #fff;
            border: 3px solid #2c3e50;
        }
        
        .member-details {
            flex-grow: 1;
        }
        
        .member-name {
            font-size: 28px;
            margin-bottom: 8px;
            color: #2c3e50;
        }
        
        .member-role {
            display: inline-block;
            background-color: #2c3e50;
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .info-group {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .info-item {
            margin-bottom: 15px;
        }
        
        .info-label {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
        }
        
        .info-value {
            font-size: 16px;
            padding: 8px 0;
        }
        
        .other-info {
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 8px;
            margin-top: 20px;
        }
        
        .action-buttons {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
        
        .btn-back {
            background-color: #7f8c8d;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-edit {
            background-color: #2ecc71;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-delete {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <%@ include file="/pages/common/header.jsp" %>
    
    <main class="container">
        <div class="admin-container">
            <div class="member-info">
                <div class="member-header">
                    <c:choose>
                        <c:when test="${not empty viewUser.avatarUrl}">
                            <img src="${viewUser.avatarUrl}" alt="${viewUser.fullName}" class="member-avatar">
                        </c:when>
                        <c:otherwise>
                            <div class="member-avatar-placeholder">
                                ${fn:substring(viewUser.fullName, 0, 1)}
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="member-details">
                        <h1 class="member-name">${viewUser.fullName}</h1>
                        <span class="member-role">${viewUser.role == 'ADMIN' ? 'Quản trị viên' : 'Thành viên'}</span>
                        <div class="info-value">${viewUser.currentJob} ${not empty viewUser.currentPosition ? '- ' : ''}${viewUser.currentPosition}</div>
                    </div>
                </div>
                
                <div class="info-group">
                    <div class="info-item">
                        <div class="info-label">Tên đăng nhập</div>
                        <div class="info-value">${viewUser.username}</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Email</div>
                        <div class="info-value">${viewUser.email}</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Số điện thoại</div>
                        <div class="info-value">${not empty viewUser.mobilePhone ? viewUser.mobilePhone : 'Chưa cập nhật'}</div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Giới tính</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${viewUser.gender == 'MALE'}">Nam</c:when>
                                <c:when test="${viewUser.gender == 'FEMALE'}">Nữ</c:when>
                                <c:otherwise>Khác</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                
                <div class="info-item">
                    <div class="info-label">Địa chỉ</div>
                    <div class="info-value">${not empty viewUser.address ? viewUser.address : 'Chưa cập nhật'}</div>
                </div>
                
                <c:if test="${not empty viewUser.otherInfo}">
                    <div class="info-item">
                        <div class="info-label">Thông tin khác</div>
                        <div class="info-value other-info">${viewUser.otherInfo}</div>
                    </div>
                </c:if>
            </div>
            
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/admin/members" class="btn-back">Quay lại</a>
                <a href="${pageContext.request.contextPath}/admin/edit-member?id=${viewUser.userId}" class="btn-edit">Sửa thông tin</a>
                <a href="#" onclick="confirmDelete(${viewUser.userId})" class="btn-delete">Xóa thành viên</a>
            </div>
        </div>
    </main>
    
    <%@ include file="/pages/common/footer.jsp" %>
    
    <script>
        function confirmDelete(userId) {
            if (confirm('Bạn có chắc chắn muốn xóa thành viên này không?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/delete-member?id=' + userId;
            }
        }
    </script>
</body>
</html>
