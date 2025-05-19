<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty sessionScope.user && sessionScope.user.role eq 'ADMIN'}">
    <!-- Include admin CSS for admin users only -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</c:if>
<header>
    <div class="container header-container">        <div class="logo">
            <h1>Quản Lý Nhóm</h1>
        </div>        <nav>
            <ul>
                <c:choose>                    <c:when test="${not empty sessionScope.user && sessionScope.user.role eq 'ADMIN'}">                        <!-- Chỉ hiển thị menu quản trị cho Admin -->
                        <li class="admin-nav-item"><a href="${pageContext.request.contextPath}/admin/members">Thành viên</a></li>
                    </c:when>
                    <c:otherwise>
                        <!-- Menu cho khách và người dùng thường -->
                        <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/members">Thành viên</a></li>
                        <li><a href="${pageContext.request.contextPath}/search">Tìm kiếm</a></li>
                        
                        <c:if test="${not empty sessionScope.user}">
                            <li><a href="${pageContext.request.contextPath}/user/profile">Hồ sơ cá nhân</a></li>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
        <div class="auth-buttons">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-login">Đăng nhập</a>
                </c:when>                <c:otherwise>
                    <span style="margin-right: 10px; color: white;">
                        Xin chào, ${sessionScope.user.fullName}
                        <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                            <span style="color: #ffc107; font-weight: bold; margin-left: 5px;">[ADMIN]</span>
                        </c:if>
                    </span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-login">Đăng xuất</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header> 