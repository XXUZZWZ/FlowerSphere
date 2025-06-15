package com.bloomsphere.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/bloomsphere?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "12341234q"; // 请根据实际情况修改

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }
} 