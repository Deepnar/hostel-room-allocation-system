package com.hostel.dao;

import java.sql.*;
import java.util.*;
import com.hostel.model.Room;
import com.hostel.util.DBConnection;

public class RoomDAO {

    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM rooms ORDER BY id ASC"; 
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                Room r = new Room();
                r.setId(rs.getInt("id"));
                r.setRoomNumber(rs.getString("room_number"));
                r.setType(rs.getString("type"));
                
                r.setCapacity(rs.getInt("capacity")); 
                
                r.setPrice(rs.getDouble("price"));
                r.setStatus(rs.getString("status"));
                list.add(r);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addRoom(Room room) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO rooms (room_number, type, capacity, price, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getType());
            ps.setInt(3, room.getCapacity());
            ps.setDouble(4, room.getPrice());
            ps.setString(5, "AVAILABLE");
            ps.executeUpdate();
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
}