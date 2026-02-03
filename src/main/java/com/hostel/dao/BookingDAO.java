package com.hostel.dao;
import java.sql.*;
import java.util.*;
import com.hostel.model.Booking;
import com.hostel.util.DBConnection;

public class BookingDAO {
    
    public void createBooking(Booking b) {
        try {
            Connection con = DBConnection.getConnection();
            
            String query = "INSERT INTO bookings (user_id, room_id, college_name, duration_months, total_amount) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, b.getUserId());
            ps.setInt(2, b.getRoomId());
            ps.setString(3, b.getCollegeName());
            ps.setInt(4, b.getDuration());
            ps.setDouble(5, b.getTotalAmount());
            ps.executeUpdate();
            
            String updateRoom = "UPDATE rooms SET status='BOOKED' WHERE id=?";
            PreparedStatement ps2 = con.prepareStatement(updateRoom);
            ps2.setInt(1, b.getRoomId());
            ps2.executeUpdate();
            
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM bookings ORDER BY booking_date DESC";
            ResultSet rs = con.createStatement().executeQuery(query);
            while(rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setRoomId(rs.getInt("room_id"));
                b.setCollegeName(rs.getString("college_name"));
                b.setTotalAmount(rs.getDouble("total_amount"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                list.add(b);
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public boolean hasActiveBooking(int userId) {
        boolean hasBooking = false;
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM bookings b JOIN rooms r ON b.room_id = r.id WHERE b.user_id = ? AND r.status = 'BOOKED'";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                hasBooking = true;
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        return hasBooking;
    }
}