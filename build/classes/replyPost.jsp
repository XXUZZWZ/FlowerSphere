<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BloomSphere - 回复帖子</title>
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
        .original-post {
            background-color: #f9f9f9;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            border-left: 4px solid #4CAF50;
        }
        .post-title {
            font-size: 1.2em;
            font-weight: bold;
            color: #4CAF50;
        }
        .post-meta {
            color: #777;
            margin: 5px 0 10px;
            font-size: 0.9em;
        }
        .post-content {
            line-height: 1.6;
            white-space: pre-wrap;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        textarea {
            width: 100%;
            height: 200px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
            resize: vertical;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
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
    
    <div class="container">
        <h1>BloomSphere - 回复帖子</h1>
        
        <div class="original-post">
            <div class="post-title">${post.title}</div>
            <div class="post-meta">
                <span>作者: ${post.username}</span>
                <span>发表时间: <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
            </div>
            <div class="post-content">${post.content}</div>
        </div>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="message"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/forum/reply" method="post">
            <input type="hidden" name="parentId" value="${post.id}">
            
            <div class="form-group">
                <label for="content">回复内容：</label>
                <textarea id="content" name="content" required></textarea>
            </div>
            
            <div style="text-align: center;">
                <button type="submit" class="btn">回复</button>
            </div>
        </form>
        
        <div style="margin-top: 20px; text-align: center;">
            <a href="${pageContext.request.contextPath}/forum/view?id=${post.id}" style="color: #4CAF50; text-decoration: none; margin: 0 10px;">返回帖子详情</a>
            <a href="${pageContext.request.contextPath}/forum/" style="color: #4CAF50; text-decoration: none; margin: 0 10px;">返回论坛</a>
        </div>
    </div>
</body>
</html> 