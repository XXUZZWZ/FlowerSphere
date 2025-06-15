package com.bloomsphere.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bloomsphere.util.DatabaseUtil;
import com.bloomsphere.model.Flower;

@WebServlet("/flower/*")
public class FlowerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession();
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        
        // 检查用户是否登录
        if (session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // 获取所有花卉
            List<Flower> flowers = getAllFlowers();
            request.setAttribute("flowers", flowers);
            request.getRequestDispatcher("/flowerList.jsp").forward(request, response);
        } else if (pathInfo.equals("/search")) {
            // 搜索花卉
            String keyword = request.getParameter("keyword");
            String category = request.getParameter("category");
            List<Flower> flowers = searchFlowers(keyword, category);
            request.setAttribute("flowers", flowers);
            request.setAttribute("keyword", keyword);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/flowerList.jsp").forward(request, response);
        } else if (pathInfo.equals("/edit") && isAdmin != null && isAdmin) {
            // 编辑花卉
            int id = Integer.parseInt(request.getParameter("id"));
            Flower flower = getFlowerById(id);
            request.setAttribute("flower", flower);
            request.getRequestDispatcher("/editFlower.jsp").forward(request, response);
        } else if (pathInfo.equals("/delete") && isAdmin != null && isAdmin) {
            // 删除花卉
            int id = Integer.parseInt(request.getParameter("id"));
            deleteFlower(id);
            response.sendRedirect(request.getContextPath() + "/flower/");
        } else {
            response.sendRedirect(request.getContextPath() + "/flower/");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession();
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        
        // 检查用户是否登录
        if (session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // 检查是否为管理员
        if (isAdmin == null || !isAdmin) {
            response.sendRedirect(request.getContextPath() + "/flower/");
            return;
        }
        
        if (pathInfo.equals("/add")) {
            // 添加花卉
            addFlower(request, response);
        } else if (pathInfo.equals("/update")) {
            // 更新花卉
            updateFlower(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/flower/");
        }
    }
    
    private List<Flower> getAllFlowers() {
        List<Flower> flowers = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT id, name, category, stock, price FROM flowers";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Flower flower = new Flower();
                flower.setId(rs.getInt("id"));
                flower.setName(rs.getString("name"));
                flower.setCategory(rs.getString("category"));
                flower.setStock(rs.getInt("stock"));
                flower.setPrice(rs.getDouble("price"));
                flowers.add(flower);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return flowers;
    }
    
    private List<Flower> searchFlowers(String keyword, String category) {
        List<Flower> flowers = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT id, name, category, stock, price FROM flowers WHERE 1=1";
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += " AND name LIKE ?";
            }
            
            if (category != null && !category.trim().isEmpty()) {
                sql += " AND category = ?";
            }
            
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + keyword + "%");
            }
            
            if (category != null && !category.trim().isEmpty()) {
                stmt.setString(paramIndex++, category);
            }
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Flower flower = new Flower();
                flower.setId(rs.getInt("id"));
                flower.setName(rs.getString("name"));
                flower.setCategory(rs.getString("category"));
                flower.setStock(rs.getInt("stock"));
                flower.setPrice(rs.getDouble("price"));
                flowers.add(flower);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return flowers;
    }
    
    private Flower getFlowerById(int id) {
        Flower flower = null;
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT id, name, category, stock, price FROM flowers WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                flower = new Flower();
                flower.setId(rs.getInt("id"));
                flower.setName(rs.getString("name"));
                flower.setCategory(rs.getString("category"));
                flower.setStock(rs.getInt("stock"));
                flower.setPrice(rs.getDouble("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return flower;
    }
    
    private void addFlower(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        int stock = Integer.parseInt(request.getParameter("stock"));
        double price = Double.parseDouble(request.getParameter("price"));
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "INSERT INTO flowers (name, category, stock, price) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, category);
            stmt.setInt(3, stock);
            stmt.setDouble(4, price);
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/flower/");
            } else {
                request.setAttribute("errorMessage", "添加花卉失败");
                request.getRequestDispatcher("/addFlower.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "添加花卉过程中发生错误");
            request.getRequestDispatcher("/addFlower.jsp").forward(request, response);
        }
    }
    
    private void updateFlower(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        int stock = Integer.parseInt(request.getParameter("stock"));
        double price = Double.parseDouble(request.getParameter("price"));
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "UPDATE flowers SET name = ?, category = ?, stock = ?, price = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, category);
            stmt.setInt(3, stock);
            stmt.setDouble(4, price);
            stmt.setInt(5, id);
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/flower/");
            } else {
                request.setAttribute("errorMessage", "更新花卉失败");
                request.setAttribute("flower", getFlowerById(id));
                request.getRequestDispatcher("/editFlower.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "更新花卉过程中发生错误");
            request.setAttribute("flower", getFlowerById(id));
            request.getRequestDispatcher("/editFlower.jsp").forward(request, response);
        }
    }
    
    private void deleteFlower(int id) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "DELETE FROM flowers WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} 