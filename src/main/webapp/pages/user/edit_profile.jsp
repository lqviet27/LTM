<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Chỉnh sửa thông tin</title>
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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        .form-actions {
            margin-top: 30px;
            text-align: right;
        }
        
        .btn-submit {
            padding: 12px 20px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        
        .btn-submit:hover {
            background-color: #34495e;
        }
        
        .btn-cancel {
            padding: 12px 20px;
            background-color: #7f8c8d;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-right: 10px;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-cancel:hover {
            background-color: #95a5a6;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="/pages/common/header.jsp" %>
    
    <main class="container">
        <div class="profile-container">
            <h2 style="text-align: center; margin-bottom: 30px;">Chỉnh sửa thông tin cá nhân</h2>
            
            <% if(request.getAttribute("error") != null) { %>
            <div class="error-message">
                ${error}
            </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/user/edit-profile" method="POST">
                <div class="form-group">
                    <label for="fullName">Họ và tên</label>
                    <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="${user.email}" required>
                </div>
                
                <div class="form-group">
                    <label for="mobilePhone">Số điện thoại</label>
                    <input type="tel" id="mobilePhone" name="mobilePhone" value="${user.mobilePhone}">
                </div>
                
                <div class="form-group">
                    <label for="address">Địa chỉ</label>
                    <input type="text" id="address" name="address" value="${user.address}">
                </div>
                
                <div class="form-group">
                    <label for="currentJob">Công việc hiện tại</label>
                    <input type="text" id="currentJob" name="currentJob" value="${user.currentJob}">
                </div>
                
                <div class="form-group">
                    <label for="currentPosition">Chức vụ hiện tại</label>
                    <input type="text" id="currentPosition" name="currentPosition" value="${user.currentPosition}">
                </div>
                
                <div class="form-group">
                    <label for="otherInfo">Thông tin khác</label>
                    <textarea id="otherInfo" name="otherInfo">${user.otherInfo}</textarea>
                </div>
                
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/user/profile" class="btn-cancel">Hủy</a>
                    <button type="submit" class="btn-submit">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </main>
    
    <%@ include file="/pages/common/footer.jsp" %>
</body>
</html> 