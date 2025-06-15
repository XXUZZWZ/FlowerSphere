<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BloomSphere - 花卉列表</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #4CAF50;
        }
        .search-box {
            margin: 20px 0;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-danger {
            background-color: #f44336;
        }
        .btn-primary {
            background-color: #2196F3;
        }
        .btn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="container">
        <h1>BloomSphere - 花卉列表</h1>
        
        <div class="search-box">
            <form action="${pageContext.request.contextPath}/flower/search" method="get">
                <table>
                    <tr>
                        <td width="15%">按名称搜索：</td>
                        <td width="30%"><input type="text" name="keyword" value="${keyword}" style="width: 100%;"></td>
                        <td width="15%">按类别筛选：</td>
                        <td width="30%">
                            <select name="category" style="width: 100%;">
                                <option value="">--请选择--</option>
                                <option value="室内植物" ${category == '室内植物' ? 'selected' : ''}>室内植物</option>
                                <option value="室外植物" ${category == '室外植物' ? 'selected' : ''}>室外植物</option>
                                <option value="观赏花卉" ${category == '观赏花卉' ? 'selected' : ''}>观赏花卉</option>
                                <option value="盆栽" ${category == '盆栽' ? 'selected' : ''}>盆栽</option>
                                <option value="多肉植物" ${category == '多肉植物' ? 'selected' : ''}>多肉植物</option>
                            </select>
                        </td>
                        <td><button type="submit" class="btn">搜索</button></td>
                    </tr>
                </table>
            </form>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>名称</th>
                    <th>类别</th>
                    <th>库存</th>
                    <th>价格</th>
                    <c:if test="${sessionScope.isAdmin}">
                        <th>操作</th>
                    </c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${flowers}" var="flower">
                    <tr>
                        <td>${flower.name}</td>
                        <td>${flower.category}</td>
                        <td>${flower.stock}</td>
                        <td>¥${flower.price}</td>
                        <c:if test="${sessionScope.isAdmin}">
                            <td>
                                <a href="${pageContext.request.contextPath}/flower/edit?id=${flower.id}" class="btn btn-primary">编辑</a>
                                <a href="javascript:void(0);" onclick="deleteFlower(${flower.id})" class="btn btn-danger">删除</a>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <c:if test="${sessionScope.isAdmin}">
            <div style="margin-top: 20px; text-align: right;">
                <a href="${pageContext.request.contextPath}/addFlower.jsp" class="btn">添加花卉</a>
            </div>
        </c:if>
    </div>
    
    <script>
        function deleteFlower(id) {
            if (confirm("确定要删除这个花卉吗？")) {
                window.location.href = "${pageContext.request.contextPath}/flower/delete?id=" + id;
            }
        }
    </script>
</body>
</html> 