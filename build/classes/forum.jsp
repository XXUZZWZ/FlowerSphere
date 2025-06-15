<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BloomSphere - 花友论坛</title>
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
        .btn:hover {
            opacity: 0.8;
        }
        .post-title {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .post-title:hover {
            color: #4CAF50;
        }
        .post-info {
            color: #777;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="container">
        <h1>BloomSphere - 花友论坛</h1>
        
        <div style="margin: 20px 0; text-align: right;">
            <a href="${pageContext.request.contextPath}/forum/newPost" class="btn">发表新帖</a>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th width="60%">标题</th>
                    <th width="20%">作者</th>
                    <th width="20%">发表时间</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${posts}" var="post">
                    <tr>
                        <td>
                            <a href="${pageContext.request.contextPath}/forum/view?id=${post.id}" class="post-title">${post.title}</a>
                        </td>
                        <td>${post.username}</td>
                        <td>
                            <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty posts}">
                    <tr>
                        <td colspan="3" style="text-align: center;">暂无帖子</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html> 