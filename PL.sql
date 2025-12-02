-- RESET STORED PROCEDURE FOR CAMPUS CONNECT
DROP PROCEDURE IF EXISTS reset_database;
DELIMITER $$

CREATE PROCEDURE reset_database()
BEGIN
    DROP TABLE IF EXISTS EventAttendance;
    DROP TABLE IF EXISTS FundingRequests;
    DROP TABLE IF EXISTS Events;
    DROP TABLE IF EXISTS Students;
    DROP TABLE IF EXISTS Clubs;

    CREATE TABLE Clubs (
      clubID INT AUTO_INCREMENT PRIMARY KEY,
      clubName VARCHAR(100) UNIQUE NOT NULL,
      description VARCHAR(255),
      budget DECIMAL(10,2)
    );

    CREATE TABLE Students (
      studentID INT AUTO_INCREMENT PRIMARY KEY,
      firstName VARCHAR(50),
      lastName VARCHAR(50),
      email VARCHAR(100) UNIQUE
    );

    CREATE TABLE Events (
      eventID INT AUTO_INCREMENT PRIMARY KEY,
      eventName VARCHAR(100) NOT NULL,
      eventDate DATE,
      location VARCHAR(100),
      clubID INT,
      FOREIGN KEY (clubID) REFERENCES Clubs(clubID)
        ON DELETE CASCADE ON UPDATE CASCADE
    );

    CREATE TABLE FundingRequests (
      requestID INT AUTO_INCREMENT PRIMARY KEY,
      amountRequested DECIMAL(10,2) NOT NULL,
      status VARCHAR(20),
      submittedDate DATE,
      eventID INT,
      FOREIGN KEY (eventID) REFERENCES Events(eventID)
        ON DELETE CASCADE ON UPDATE CASCADE
    );

    CREATE TABLE EventAttendance (
      attendanceID INT AUTO_INCREMENT PRIMARY KEY,
      checkInTime DATETIME,
      studentID INT,
      eventID INT,
      FOREIGN KEY (studentID) REFERENCES Students(studentID)
        ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY (eventID) REFERENCES Events(eventID)
        ON DELETE CASCADE ON UPDATE CASCADE
    );

    INSERT INTO Clubs (clubName, description, budget) VALUES
      ('Robotics Club','Builds robots',5000),
      ('Art Society','Campus art events',3000);

    INSERT INTO Students (firstName,lastName,email) VALUES
      ('Mia','Hajj','mia.hajj@oregonstate.edu'),
      ('Lea','Hajj','lea.hajj@oregonstate.edu');

    INSERT INTO Events (eventName,eventDate,location,clubID) VALUES
      ('Tech Expo','2025-05-02','Engineering Hall',1),
      ('Art Expo','2025-04-10','Memorial Union',2);

    INSERT INTO FundingRequests (amountRequested,status,submittedDate,eventID) VALUES
      (1200,'Approved','2025-04-12',1),
      (800,'Pending','2025-03-29',2);

    INSERT INTO EventAttendance (checkInTime,studentID,eventID) VALUES
      ('2025-05-02 10:05',1,1),
      ('2025-04-10 11:00',2,2);
END$$
DELIMITER ;

