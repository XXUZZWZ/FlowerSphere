<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BloomSphere - 编辑花卉</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 500px;
            margin: 50px auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #4CAF50;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .message {
            margin: 15px 0;
            color: #f44336;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <c:if test="${empty sessionScope.userId || !sessionScope.isAdmin}">
        <c:redirect url="/flower/"/>
    </c:if>

    <div class="container">
        <h1>BloomSphere</h1>
        <h2 style="text-align: center;">编辑花卉</h2>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="message"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/flower/update" method="post">
            <input type="hidden" name="id" value="${flower.id}">
            
            <div class="form-group">
                <label for="name">花卉名称：</label>
                <input type="text" id="name" name="name" value="${flower.name}" required>
            </div>
            
            <div class="form-group">
                <label for="category">类别：</label>
                <select id="category" name="category" required>
                    <option value="">--请选择--</option>
                    <option value="室内植物" ${flower.category == '室内植物' ? 'selected' : ''}>室内植物</option>
                    <option value="室外植物" ${flower.category == '室外植物' ? 'selected' : ''}>室外植物</option>
                    <option value="观赏花卉" ${flower.category == '观赏花卉' ? 'selected' : ''}>观赏花卉</option>
                    <option value="盆栽" ${flower.category == '盆栽' ? 'selected' : ''}>盆栽</option>
                    <option value="多肉植物" ${flower.category == '多肉植物' ? 'selected' : ''}>多肉植物</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="stock">库存数量：</label>
                <input type="number" id="stock" name="stock" value="${flower.stock}" min="0" required>
            </div>
            
            <div class="form-group">
                <label for="price">价格：</label>
                <input type="number" id="price" name="price" value="${flower.price}" min="0" step="0.01" required>
            </div>
            
            <button type="submit" class="btn">更新</button>
        </form>
        
        <div style="text-align: center; margin-top: 15px;">
            <a href="${pageContext.request.contextPath}/flower/" style="color: #4CAF50; text-decoration: none;">返回花卉列表</a>
        </div>
    </div>
</body>
</html> 