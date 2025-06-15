package com.bloomsphere.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bloomsphere.util.DatabaseUtil;
import com.bloomsphere.model.ForumPost;

@WebServlet("/forum/*")
public class ForumServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession();
        
        // 检查用户是否登录
        if (session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // 获取所有主题帖
            List<ForumPost> posts = getAllMainPosts();
            request.setAttribute("posts", posts);
            request.getRequestDispatcher("/forum.jsp").forward(request, response);
        } else if (pathInfo.equals("/view")) {
            // 查看帖子详情
            int postId = Integer.parseInt(request.getParameter("id"));
            ForumPost post = getPostById(postId);
            List<ForumPost> replies = getRepliesByPostId(postId);
            
            request.setAttribute("post", post);
            request.setAttribute("replies", replies);
            request.getRequestDispatcher("/viewPost.jsp").forward(request, response);
        } else if (pathInfo.equals("/newPost")) {
            // 新建帖子页面
            request.getRequestDispatcher("/newPost.jsp").forward(request, response);
        } else if (pathInfo.equals("/reply")) {
            // 回复页面
            int postId = Integer.parseInt(request.getParameter("id"));
            ForumPost post = getPostById(postId);
            request.setAttribute("post", post);
            request.getRequestDispatcher("/replyPost.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/forum/");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession();
        
        // 检查用户是否登录
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        if (pathInfo.equals("/post")) {
            // 发表新帖
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            
            if (title == null || content == null || title.trim().isEmpty() || content.trim().isEmpty()) {
                request.setAttribute("errorMessage", "标题和内容不能为空");
                request.getRequestDispatcher("/newPost.jsp").forward(request, response);
                return;
            }
            
            try (Connection conn = DatabaseUtil.getConnection()) {
                String sql = "INSERT INTO forum_posts (user_id, title, content, parent_id) VALUES (?, ?, ?, 0)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                stmt.setString(2, title);
                stmt.setString(3, content);
                
                int result = stmt.executeUpdate();
                
                if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/forum/");
                } else {
                    request.setAttribute("errorMessage", "发表帖子失败");
                    request.getRequestDispatcher("/newPost.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "发表帖子过程中发生错误");
                request.getRequestDispatcher("/newPost.jsp").forward(request, response);
            }
        } else if (pathInfo.equals("/reply")) {
            // 回复帖子
            int parentId = Integer.parseInt(request.getParameter("parentId"));
            String content = request.getParameter("content");
            
            if (content == null || content.trim().isEmpty()) {
                request.setAttribute("errorMessage", "回复内容不能为空");
                ForumPost post = getPostById(parentId);
                request.setAttribute("post", post);
                request.getRequestDispatcher("/replyPost.jsp").forward(request, response);
                return;
            }
            
            try (Connection conn = DatabaseUtil.getConnection()) {
                String sql = "INSERT INTO forum_posts (user_id, title, content, parent_id) VALUES (?, null, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                stmt.setString(2, content);
                stmt.setInt(3, parentId);
                
                int result = stmt.executeUpdate();
                
                if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/forum/view?id=" + parentId);
                } else {
                    request.setAttribute("errorMessage", "回复帖子失败");
                    ForumPost post = getPostById(parentId);
                    request.setAttribute("post", post);
                    request.getRequestDispatcher("/replyPost.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "回复帖子过程中发生错误");
                ForumPost post = getPostById(parentId);
                request.setAttribute("post", post);
                request.getRequestDispatcher("/replyPost.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/forum/");
        }
    }
    
    private List<ForumPost> getAllMainPosts() {
        List<ForumPost> posts = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT p.id, p.user_id, u.username, p.title, p.content, p.created_at " +
                         "FROM forum_posts p " +
                         "JOIN users u ON p.user_id = u.id " +
                         "WHERE p.parent_id = 0 " +
                         "ORDER BY p.created_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ForumPost post = new ForumPost();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUsername(rs.getString("username"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setParentId(0);
                post.setCreatedAt(rs.getTimestamp("created_at"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return posts;
    }
    
    private ForumPost getPostById(int id) {
        ForumPost post = null;
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT p.id, p.user_id, u.username, p.title, p.content, p.parent_id, p.created_at " +
                         "FROM forum_posts p " +
                         "JOIN users u ON p.user_id = u.id " +
                         "WHERE p.id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                post = new ForumPost();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setUsername(rs.getString("username"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setParentId(rs.getInt("parent_id"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return post;
    }
    
    private List<ForumPost> getRepliesByPostId(int postId) {
        List<ForumPost> replies = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT p.id, p.user_id, u.username, p.title, p.content, p.created_at " +
                         "FROM forum_posts p " +
                         "JOIN users u ON p.user_id = u.id " +
                         "WHERE p.parent_id = ? " +
                         "ORDER BY p.created_at ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, postId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ForumPost reply = new ForumPost();
                reply.setId(rs.getInt("id"));
                reply.setUserId(rs.getInt("user_id"));
                reply.setUsername(rs.getString("username"));
                reply.setTitle(rs.getString("title"));
                reply.setContent(rs.getString("content"));
                reply.setParentId(postId);
                reply.setCreatedAt(rs.getTimestamp("created_at"));
                replies.add(reply);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return replies;
    }
} 