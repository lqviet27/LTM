<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Nhóm - Quản lý thành viên</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 40px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .member-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .member-table th, .member-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        
        .member-table th {
            background-color: #2c3e50;
            color: white;
        }
        
        .member-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .member-table tr:hover {
            background-color: #f1f1f1;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .btn-view, .btn-edit, .btn-delete {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            color: white;
            display: inline-block;
        }
        
        .btn-view {
            background-color: #3498db;
        }
        
        .btn-edit {
            background-color: #2ecc71;
        }
        
        .btn-delete {
            background-color: #e74c3c;
        }
        
        .btn-add {
            background-color: #2c3e50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
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
            <h1>Quản lý thành viên</h1>
            
            <c:if test="${param.success eq 'added'}">
                <div class="success-message">
                    Thành viên mới đã được thêm thành công!
                </div>
            </c:if>
            
            <c:if test="${param.success eq 'updated'}">
                <div class="success-message">
                    Thông tin thành viên đã được cập nhật thành công!
                </div>
            </c:if>
            
            <c:if test="${param.success eq 'deleted'}">
                <div class="success-message">
                    Đã xóa thành viên thành công!
                </div>
            </c:if>
            
            <c:if test="${param.error eq 'cannot_delete_self'}">
                <div class="error-message">
                    Bạn không thể xóa tài khoản của chính mình!
                </div>
            </c:if>
            
            <c:if test="${param.error eq 'delete_failed' || param.error eq 'invalid_id' || param.error eq 'invalid_id_format' || param.error eq 'user_not_found'}">
                <div class="error-message">
                    Có lỗi xảy ra. Vui lòng thử lại.
                </div>
            </c:if>
            
            <a href="${pageContext.request.contextPath}/admin/add-member" class="btn-add">Thêm thành viên mới</a>
            
            <table class="member-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Tên đăng nhập</th>
                        <th>Vai trò</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${members}" var="member">
                        <tr>
                            <td>${member.userId}</td>
                            <td>${member.fullName}</td>
                            <td>${member.email}</td>
                            <td>${member.username}</td>
                            <td>${member.role == 'ADMIN' ? 'Quản trị viên' : 'Thành viên'}</td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/admin/view-member?id=${member.userId}" class="btn-view">Xem</a>
                                <a href="${pageContext.request.contextPath}/admin/edit-member?id=${member.userId}" class="btn-edit">Sửa</a>
                                <a href="#" onclick="confirmDelete(${member.userId})" class="btn-delete">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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
