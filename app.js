const express = require('express');
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcrypt');
const db = require('./db');

const app = express();
setInterval(() => {}, 1000); // Keeps Node process alive
app.use(express.json());
app.use(express.static('public'));

const UPLOAD_DIR = path.join(__dirname, 'uploads');
if (!fs.existsSync(UPLOAD_DIR)) fs.mkdirSync(UPLOAD_DIR);

// Register
app.post('/register', async (req, res) => {
    const {username, password} = req.body;
    const hash = await bcrypt.hash(password, 10);
    try {
        await db.execute('INSERT INTO users (username, password) VALUES (?, ?)', [username, hash]);
        res.status(201).send('User created');
    } catch (e) {
        console.warn(e);
        res.status(400).send('Username taken');
    }
});

// Login (returns user ID)
app.post('/login', async (req, res) => {
    const {username, password} = req.body;
    const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [username]);
    const user = rows[0];
    if (user && (await bcrypt.compare(password, user.password))) {
        res.json({userId: user.id});
    } else {
        res.status(401).send('Invalid login');
    }
});

// Upload photo (raw body, ?userId=)
app.post('/upload', express.raw({type: 'application/octet-stream', limit: '10mb'}), async (req, res) => {
    const userId = req.query.userId;
    if (!req.body || !userId) return res.status(400).send('Missing data or userId');

    const filename = `photo_${Date.now()}.jpg`;
    const filepath = path.join(UPLOAD_DIR, filename);
    fs.writeFileSync(filepath, req.body);
    await db.execute('INSERT INTO photos (user_id, filename) VALUES (?, ?)', [userId, filename]);
    res.send('Photo uploaded');
});

// Get all photos for a user
app.get('/photos', async (req, res) => {
    const userId = req.query.userId;
    if (!userId) return res.status(400).send('Missing userId');
    const [rows] = await db.execute('SELECT id, filename FROM photos WHERE user_id = ?', [userId]);
    res.json(rows);
});

// Download photo
app.get('/download/:id', async (req, res) => {
    const [rows] = await db.execute('SELECT * FROM photos WHERE id = ?', [req.params.id]);
    const photo = rows[0];
    if (!photo) return res.sendStatus(404);
    res.sendFile(path.join(UPLOAD_DIR, photo.filename));
});

const PORT = process.env.PORT || 80;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Listening on port ${PORT}`);
});
