package com.hostel.dao;

import java.sql.*;
import com.hostel.model.User;
import com.hostel.util.DBConnection;

public class UserDAO {

    public User login(String email, String password) {
        User user = null;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public void register(String name, String email, String password, String role) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);
            ps.executeUpdate();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}