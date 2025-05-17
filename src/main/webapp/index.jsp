<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Chuyển hướng từ trang root đến servlet home
    response.sendRedirect(request.getContextPath() + "/home");
%>