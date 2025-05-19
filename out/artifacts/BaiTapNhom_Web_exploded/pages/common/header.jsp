<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                
                <c:if test="${not empty sessionScope.user}">
                    <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                        <li><a href="${pageContext.request.contextPath}/admin/members">Quản lý thành viên</a></li>
                    </c:if>
                    <li><a href="${pageContext.request.contextPath}/user/profile">Hồ sơ cá nhân</a></li>
                </c:if>
            </ul>
        </nav>
        <div class="auth-buttons">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Đăng nhập</a>
                </c:when>
                <c:otherwise>
                    <span style="margin-right: 10px; color: white;">Xin chào, ${sessionScope.user.fullName}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-login">Đăng xuất</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header> 