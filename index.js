const express = require('express');
const dotenv = require('dotenv');
const db = require('./db.js');

// Import Routes
const userRoutes = require('./routes/userRoutes');
const logActivitiesRoutes = require('./routes/logActivitiesRoutes');
const mediaSourcesRoutes = require('./routes/mediaSourcesRoutes');
const mediaMentionsRoutes = require('./routes/mediaMentionsRoutes');
const sentimentAnalysisRoutes = require('./routes/sentimentAnalysisRoutes');

dotenv.config();
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

// Cek koneksi ke database
db.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err.message);
    process.exit(1);
  }
  console.log('Database connected');
});

// Endpoint utama
app.get("/", (req, res) => {
  res.send("Media Monitoring API aktif!");
});

// Endpoint uji coba
app.get("/test", (req, res) => {
  res.json({ message: "API berhasil jalan!" });
});

// Daftar Routes
app.use('/users', userRoutes);
app.use('/log_activities', logActivitiesRoutes);
app.use('/media_sources', mediaSourcesRoutes);
app.use('/media_mentions', mediaMentionsRoutes);
app.use('/sentiment_analysis', sentimentAnalysisRoutes);

// Menjalankan server
app.listen(port, () => {
  console.log(`Server berjalan di port ${port}`);
});
