package com.hostel.model;

public class Room {
    private int id;
    private String roomNumber;
    private String type;
    private double price;
    private String status;
    private int capacity;

    public Room() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

	public int getCapacity() {return capacity;}

	public void setCapacity(int capacity) {this.capacity = capacity;}
}