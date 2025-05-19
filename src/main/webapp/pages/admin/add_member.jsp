<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Thêm thành viên mới</title>
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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-row .form-group {
            flex: 1;
            margin-bottom: 0;
        }
        
        .btn-submit {
            background-color: #2c3e50;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        
        .btn-cancel {
            background-color: #7f8c8d;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
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
        <div class="admin-container">
            <h1>Thêm thành viên mới</h1>
            
            <c:if test="${not empty error}">
                <div class="error-message">
                    ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/admin/add-member" method="POST">
                <div class="form-row">
                    <div class="form-group">
                        <label for="username">Tên đăng nhập*</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Mật khẩu*</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="fullName">Họ và tên*</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email*</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="gender">Giới tính*</label>
                        <select id="gender" name="gender" required>
                            <option value="MALE">Nam</option>
                            <option value="FEMALE">Nữ</option>
                            <option value="OTHER">Khác</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="mobilePhone">Số điện thoại</label>
                        <input type="tel" id="mobilePhone" name="mobilePhone">
                    </div>
                    
                    <div class="form-group">
                        <label for="role">Vai trò*</label>
                        <select id="role" name="role" required>
                            <option value="USER">Thành viên</option>
                            <option value="ADMIN">Quản trị viên</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address">Địa chỉ</label>
                    <input type="text" id="address" name="address">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="currentJob">Công việc hiện tại</label>
                        <input type="text" id="currentJob" name="currentJob">
                    </div>
                    
                    <div class="form-group">
                        <label for="currentPosition">Chức vụ hiện tại</label>
                        <input type="text" id="currentPosition" name="currentPosition">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="avatarUrl">URL Ảnh đại diện</label>
                    <input type="url" id="avatarUrl" name="avatarUrl">
                </div>
                
                <div class="form-group">
                    <label for="otherInfo">Thông tin khác</label>
                    <textarea id="otherInfo" name="otherInfo" rows="4"></textarea>
                </div>
                
                <div>
                    <a href="${pageContext.request.contextPath}/admin/members" class="btn-cancel">Hủy</a>
                    <button type="submit" class="btn-submit">Thêm thành viên</button>
                </div>
            </form>
        </div>
    </main>
    
    <%@ include file="/pages/common/footer.jsp" %>
</body>
</html>
