-- ============================
-- FULL CRUD FOR ALL TABLES
-- ============================

-- ===== CLUBS =====
SELECT * FROM Clubs;

INSERT INTO Clubs (clubName, description, budget)
VALUES (?, ?, ?);

UPDATE Clubs
SET clubName = ?, description = ?, budget = ?
WHERE clubID = ?;

DELETE FROM Clubs WHERE clubID = ?;

-- ===== STUDENTS =====
SELECT * FROM Students;

INSERT INTO Students (firstName, lastName, email)
VALUES (?, ?, ?);

UPDATE Students
SET firstName = ?, lastName = ?, email = ?
WHERE studentID = ?;

DELETE FROM Students WHERE studentID = ?;

-- ===== EVENTS =====
SELECT * FROM Events;

INSERT INTO Events (eventName, eventDate, location, clubID)
VALUES (?, ?, ?, ?);

UPDATE Events
SET eventName = ?, eventDate = ?, location = ?, clubID = ?
WHERE eventID = ?;

DELETE FROM Events WHERE eventID = ?;

-- ===== FUNDING REQUESTS =====
SELECT * FROM FundingRequests;

INSERT INTO FundingRequests (amountRequested, status, submittedDate, eventID)
VALUES (?, ?, ?, ?);

UPDATE FundingRequests
SET amountRequested = ?, status = ?, submittedDate = ?, eventID = ?
WHERE requestID = ?;

DELETE FROM FundingRequests WHERE requestID = ?;

-- ===== EVENT ATTENDANCE =====
SELECT * FROM EventAttendance;

INSERT INTO EventAttendance (checkInTime, studentID, eventID)
VALUES (?, ?, ?);

UPDATE EventAttendance
SET checkInTime = ?, studentID = ?, eventID = ?
WHERE attendanceID = ?;

DELETE FROM EventAttendance WHERE attendanceID = ?;

