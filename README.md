# ZenHostel – Hostel Room Allocation System

ZenHostel is a Core Java–based web application designed to streamline hostel room allocation. It features a clean, Zen-inspired user interface, role-based access control (Student, Guest, Admin), and intelligent booking logic to prevent conflicts and manage occupancy efficiently.

---

## Project Overview

### Tech Stack
- Java (Servlets, JSP)
- JDBC
- MySQL
- HTML5, CSS3 (Custom Zen Theme)

### Architecture
- MVC (Model–View–Controller)

### IDE
- Eclipse (Dynamic Web Project)

### Server
- Apache Tomcat 9.0+

---

## Key Features

### User Side (Student / Guest)

- **Smart Registration**  
  Automatically detects students based on email domain (`@uni.edu`) and assigns the `STUDENT` role.

- **Dynamic Pricing**  
  Students receive an automatic 20% discount on room bookings.

- **Room Dashboard**  
  View all rooms with real-time status (Available / Occupied), capacity, and amenities.

- **Conflict Prevention**  
  Users cannot book more than one room at a time.

- **Profile Management**  
  Users can view confirmed booking details including room number, duration, and total amount paid.

---

### Admin Side (Warden)

- **Secure Dashboard**  
  Dedicated admin control panel separate from the user interface.

- **Live Analytics**
  - Total Earnings (INR)
  - Occupancy Rate
  - Total Active Bookings

- **Room Management**  
  Add new rooms with configurable type (AC / Non-AC), capacity, and pricing.

- **Booking Ledger**  
  View a master list of all bookings with user details and timestamps.

---

## Database Setup (MySQL)

Run the following SQL script in MySQL Workbench or the MySQL command line.

```sql
DROP DATABASE IF EXISTS hostel_db;
CREATE DATABASE hostel_db;
USE hostel_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    role VARCHAR(20)
);

CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10),
    type VARCHAR(50),
    capacity INT,
    price DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'AVAILABLE'
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    room_id INT,
    college_name VARCHAR(100),
    duration_months INT,
    total_amount DECIMAL(10,2),
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

INSERT INTO users (name, email, password, role)
VALUES ('Warden', 'admin@hostel.com', 'admin123', 'ADMIN');

INSERT INTO rooms (room_number, type, capacity, price, status) VALUES
('101', 'AC', 1, 15000.00, 'AVAILABLE'),
('102', 'Non-AC', 2, 8000.00, 'AVAILABLE'),
('103', 'Luxury AC', 1, 25000.00, 'AVAILABLE');
```
## How to Run

### 1. Database Configuration
Open `DBConnection.java` and update the database URL, username, and password according to your local MySQL setup.

### 2. Dependencies
Ensure `mysql-connector-j-8.x.x.jar` is placed inside `WEB-INF/lib` and added to the project Build Path.

### 3. Server Setup
Right-click the project → **Run As** → **Run on Server** → **Apache Tomcat**

---

## Access URLs

- **Login:**  
  http://localhost:8080/HostelAllocation/login.jsp

- **Admin Login:**  
  - Email: `admin@hostel.com`  
  - Password: `admin123`

- **Student Test Account:**  
  Register using any email ending with `@uni.edu`

---

## UI and Design

The application uses a custom Zen-themed CSS design focused on clarity and usability.

### Color Palette
- Background: `#FDF6E3`
- Text: `#2C241E`
- Accents: `#D29C22`, `#DE5E30`

### Typography
- Google Font: **Outfit**

### Design Components
- Rounded cards  
- Soft shadows  
- Responsive grid layouts  

---

## Application Workflow

ZenHostel follows the MVC (Model–View–Controller) architecture.

### Login Flow
1. User submits credentials on `login.jsp`
2. POST request sent to `AuthServlet`
3. `AuthServlet` calls `UserDAO.login()`
4. Database validates credentials
5. Redirect based on role:
   - Admin → `admin_dashboard.jsp`
   - Student / Guest → `dashboard.jsp`

---

### Booking Flow
1. User selects a room from `dashboard.jsp`
2. Booking details entered in `booking.jsp`
3. `BookingServlet`:
   - Verifies login
   - Prevents multiple active bookings
   - Calculates total price
   - Applies 20% discount for students
4. `BookingDAO`:
   - Inserts booking record
   - Updates room status to `BOOKED`
5. User is redirected to `profile.jsp`

---

### Admin Flow
1. Admin accesses `admin_dashboard.jsp`
2. System calculates:
   - Total earnings
   - Occupancy rate
   - Active bookings
3. Admin adds new rooms via `AdminServlet`
4. Rooms become instantly available for booking

---

## File Responsibility Guide

### Controllers
- `AuthServlet.java` – Authentication, registration, role routing
- `BookingServlet.java` – Booking logic, pricing, validation
- `AdminServlet.java` – Room creation and admin analytics

### DAO Layer
- `UserDAO.java` – User authentication and registration
- `RoomDAO.java` – Room retrieval and creation
- `BookingDAO.java` – Booking persistence and room locking

### Models
- `User.java` – User entity
- `Room.java` – Room entity
- `Booking.java` – Booking entity

### Utility
- `DBConnection.java` – JDBC database connection

### Frontend (JSP Views)
- `login.jsp` – Entry point  
- `register.jsp` – Account creation  
- `dashboard.jsp` – Room listing  
- `booking.jsp` – Booking form  
- `profile.jsp` – User booking details  
- `admin_dashboard.jsp` – Admin control panel  
- `style.css` – Zen UI theme  

---

## Future Enhancements
- Payment gateway integration
- Email notifications
- Complaint management system
- Multi-admin support with role-based permissions
