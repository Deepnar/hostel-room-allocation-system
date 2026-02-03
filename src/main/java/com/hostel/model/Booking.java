package com.hostel.model;
import java.sql.Timestamp;

public class Booking {
    private int id, userId, roomId, duration;
    private String collegeName;
    private double totalAmount;
    private Timestamp bookingDate;
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int u) { this.userId = u; }
    public int getRoomId() { return roomId; }
    public void setRoomId(int r) { this.roomId = r; }
    public String getCollegeName() { return collegeName; }
    public void setCollegeName(String c) { this.collegeName = c; }
    public int getDuration() { return duration; }
    public void setDuration(int d) { this.duration = d; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double t) { this.totalAmount = t; }
    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp t) { this.bookingDate = t; }
}