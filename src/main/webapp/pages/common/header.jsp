<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <div class="container header-container">
        <div class="logo">
            <h1>Quản Lý Nhóm</h1>
        </div>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/members">Thành viên</a></li>
                <li><a href="${pageContext.request.contextPath}/search">Tìm kiếm</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Đăng nhập</a>
        </div>
    </div>
</header> 