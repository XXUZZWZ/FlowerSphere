<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BloomSphere - 发表新帖</title>
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
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
        }
        textarea {
            height: 200px;
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
        <h1>BloomSphere - 发表新帖</h1>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="message"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/forum/post" method="post">
            <div class="form-group">
                <label for="title">标题：</label>
                <input type="text" id="title" name="title" required>
            </div>
            
            <div class="form-group">
                <label for="content">内容：</label>
                <textarea id="content" name="content" required></textarea>
            </div>
            
            <div style="text-align: center;">
                <button type="submit" class="btn">发表</button>
            </div>
        </form>
        
        <div style="margin-top: 20px; text-align: center;">
            <a href="${pageContext.request.contextPath}/forum/" style="color: #4CAF50; text-decoration: none; margin: 0 10px;">返回论坛</a>
        </div>
    </div>
</body>
</html> 