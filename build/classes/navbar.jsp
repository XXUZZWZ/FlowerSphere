<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar">
    <div class="navbar-left">
        <a href="${pageContext.request.contextPath}/flower/" class="nav-link">花卉列表</a>
        <a href="${pageContext.request.contextPath}/forum/" class="nav-link">论坛</a>
    </div>
    <div class="navbar-right">
        <span>欢迎, ${sessionScope.username}</span>
        <a href="${pageContext.request.contextPath}/changePassword.jsp" class="nav-link">修改密码</a>
        <a href="${pageContext.request.contextPath}/user/logout" class="nav-link">退出登录</a>
    </div>
</div>

<style>
.navbar {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}
.navbar-left, .navbar-right {
    display: flex;
    align-items: center;
}
.nav-link {
    color: white;
    text-decoration: none;
    margin: 0 10px;
    padding: 5px 10px;
    border-radius: 3px;
}
.nav-link:hover {
    background-color: rgba(255, 255, 255, 0.2);
}
.navbar-right span {
    margin-right: 15px;
}
</style> 