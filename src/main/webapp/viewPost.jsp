<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BloomSphere - ${post.title}</title>
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
        .post {
            margin-bottom: 30px;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 20px;
        }
        .post-title {
            font-size: 1.5em;
            color: #4CAF50;
        }
        .post-meta {
            color: #777;
            margin: 10px 0;
        }
        .post-content {
            line-height: 1.6;
            margin: 20px 0;
            white-space: pre-wrap;
        }
        .reply {
            background-color: #f9f9f9;
            margin: 15px 0;
            padding: 15px;
            border-radius: 5px;
        }
        .reply-meta {
            color: #777;
            margin-bottom: 10px;
        }
        .reply-content {
            line-height: 1.4;
            white-space: pre-wrap;
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
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="container">
        <h1>BloomSphere - 花友论坛</h1>
        
        <div class="post">
            <div class="post-title">${post.title}</div>
            <div class="post-meta">
                <span>作者: ${post.username}</span>
                <span>发表时间: <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
            </div>
            <div class="post-content">${post.content}</div>
        </div>
        
        <h3>回复列表</h3>
        <c:forEach items="${replies}" var="reply">
            <div class="reply">
                <div class="reply-meta">
                    <span>${reply.username}</span>
                    <span>回复于: <fmt:formatDate value="${reply.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                </div>
                <div class="reply-content">${reply.content}</div>
            </div>
        </c:forEach>
        
        <c:if test="${empty replies}">
            <p style="text-align: center;">暂无回复</p>
        </c:if>
        
        <div style="margin: 20px 0; text-align: right;">
            <a href="${pageContext.request.contextPath}/forum/reply?id=${post.id}" class="btn">回复帖子</a>
        </div>
        
        <div style="margin-top: 20px; text-align: center;">
            <a href="${pageContext.request.contextPath}/forum/" style="color: #4CAF50; text-decoration: none; margin: 0 10px;">返回论坛</a>
        </div>
    </div>
</body>
</html> 