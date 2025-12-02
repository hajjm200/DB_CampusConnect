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
  FOREIGN KEY (clubID)
    REFERENCES Clubs(clubID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE FundingRequests (
  requestID INT AUTO_INCREMENT PRIMARY KEY,
  amountRequested DECIMAL(10,2) NOT NULL,
  status VARCHAR(20),
  submittedDate DATE,
  eventID INT,
  FOREIGN KEY (eventID)
    REFERENCES Events(eventID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE EventAttendance (
  attendanceID INT AUTO_INCREMENT PRIMARY KEY,
  checkInTime DATETIME,
  studentID INT,
  eventID INT,
  FOREIGN KEY (studentID)
    REFERENCES Students(studentID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (eventID)
    REFERENCES Events(eventID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- sample data
INSERT INTO Clubs (clubName, description, budget)
VALUES ('Robotics Club','Builds robots',5000.00),
       ('Art Society','Campus art events',2000.00);

INSERT INTO Students (firstName,lastName,email)
VALUES ('Mia','Hajj','mia.hajj@oregonstate.edu'),
       ('Lea','Hajj','lea.hajj@oregonstate.edu');

