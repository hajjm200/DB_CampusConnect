const express = require('express');
const app = express();
const path = require('path');
const db = require('./db-connector.js');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname)));

// RESET
app.get('/reset', async (req, res) => {
  try {
    await db.query("CALL reset_database();");
    res.send("Database has been RESET successfully.");
  } catch (err) {
    res.status(500).send("RESET failed.");
  }
});

/* -------------------------------------------
   SELECT ROUTES
------------------------------------------- */
app.get('/api/clubs', async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Clubs;");
  res.json(rows);
});

app.get('/api/students', async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Students;");
  res.json(rows);
});

app.get('/api/events', async (req, res) => {
  const [rows] = await db.query("SELECT * FROM Events;");
  res.json(rows);
});

app.get('/api/funding', async (req, res) => {
  const [rows] = await db.query("SELECT * FROM FundingRequests;");
  res.json(rows);
});

app.get('/api/attendance', async (req, res) => {
  const [rows] = await db.query("SELECT * FROM EventAttendance;");
  res.json(rows);
});

/* -------------------------------------------
   INSERT (POST)
------------------------------------------- */
app.post('/api/clubs', async (req, res) => {
  const { clubName, description, budget } = req.body;
  await db.query(
    "INSERT INTO Clubs (clubName, description, budget) VALUES (?, ?, ?)",
    [clubName, description, budget]
  );
  res.sendStatus(200);
});

app.post('/api/students', async (req, res) => {
  const { firstName, lastName, email } = req.body;
  await db.query(
    "INSERT INTO Students (firstName, lastName, email) VALUES (?, ?, ?)",
    [firstName, lastName, email]
  );
  res.sendStatus(200);
});

app.post('/api/events', async (req, res) => {
  const { eventName, eventDate, location, clubID } = req.body;
  await db.query(
    "INSERT INTO Events (eventName, eventDate, location, clubID) VALUES (?, ?, ?, ?)",
    [eventName, eventDate, location, clubID]
  );
  res.sendStatus(200);
});

app.post('/api/funding', async (req, res) => {
  const { amountRequested, status, submittedDate, eventID } = req.body;
  await db.query(
    "INSERT INTO FundingRequests (amountRequested, status, submittedDate, eventID) VALUES (?, ?, ?, ?)",
    [amountRequested, status, submittedDate, eventID]
  );
  res.sendStatus(200);
});

app.post('/api/attendance', async (req, res) => {
  const { checkInTime, studentID, eventID } = req.body;
  await db.query(
    "INSERT INTO EventAttendance (checkInTime, studentID, eventID) VALUES (?, ?, ?)",
    [checkInTime, studentID, eventID]
  );
  res.sendStatus(200);
});

/* -------------------------------------------
   UPDATE (PUT)
------------------------------------------- */
app.put('/api/clubs/:id', async (req, res) => {
  const id = req.params.id;
  const { clubName, description, budget } = req.body;
  await db.query(
    "UPDATE Clubs SET clubName=?, description=?, budget=? WHERE clubID=?",
    [clubName, description, budget, id]
  );
  res.sendStatus(200);
});

app.put('/api/students/:id', async (req, res) => {
  const id = req.params.id;
  const { firstName, lastName, email } = req.body;
  await db.query(
    "UPDATE Students SET firstName=?, lastName=?, email=? WHERE studentID=?",
    [firstName, lastName, email, id]
  );
  res.sendStatus(200);
});

app.put('/api/events/:id', async (req, res) => {
  const id = req.params.id;
  const { eventName, eventDate, location, clubID } = req.body;
  await db.query(
    "UPDATE Events SET eventName=?, eventDate=?, location=?, clubID=? WHERE eventID=?",
    [eventName, eventDate, location, clubID, id]
  );
  res.sendStatus(200);
});

app.put('/api/funding/:id', async (req, res) => {
  const id = req.params.id;
  const { amountRequested, status, submittedDate, eventID } = req.body;
  await db.query(
    "UPDATE FundingRequests SET amountRequested=?, status=?, submittedDate=?, eventID=? WHERE requestID=?",
    [amountRequested, status, submittedDate, eventID, id]
  );
  res.sendStatus(200);
});

app.put('/api/attendance/:id', async (req, res) => {
  const id = req.params.id;
  const { checkInTime, studentID, eventID } = req.body;
  await db.query(
    "UPDATE EventAttendance SET checkInTime=?, studentID=?, eventID=? WHERE attendanceID=?",
    [checkInTime, studentID, eventID, id]
  );
  res.sendStatus(200);
});

/* -------------------------------------------
   DELETE
------------------------------------------- */
app.delete('/api/clubs/:id', async (req, res) => {
  await db.query("DELETE FROM Clubs WHERE clubID=?", [req.params.id]);
  res.sendStatus(200);
});

app.delete('/api/students/:id', async (req, res) => {
  await db.query("DELETE FROM Students WHERE studentID=?", [req.params.id]);
  res.sendStatus(200);
});

app.delete('/api/events/:id', async (req, res) => {
  await db.query("DELETE FROM Events WHERE eventID=?", [req.params.id]);
  res.sendStatus(200);
});

app.delete('/api/funding/:id', async (req, res) => {
  await db.query("DELETE FROM FundingRequests WHERE requestID=?", [req.params.id]);
  res.sendStatus(200);
});

app.delete('/api/attendance/:id', async (req, res) => {
  await db.query("DELETE FROM EventAttendance WHERE attendanceID=?", [req.params.id]);
  res.sendStatus(200);
});

/* -------------------------------------------
   SERVER START
------------------------------------------- */
const PORT = 8302;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Campus Connect running at http://classwork.engr.oregonstate.edu:${PORT}`);
});

