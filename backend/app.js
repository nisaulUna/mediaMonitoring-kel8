require("dotenv").config()
const express = require("express")
const app = express()
const PORT = 3000
const cookieParser = require('cookie-parser');

// Middleware
app.use(express.json())
app.use(cookieParser());

// Routing
const authRoutes = require('./routes/authRoutes');
const projectRoute = require("./routes/projectRoute");
const sentimentRoute = require('./routes/sentimentRoute');
const redisRoute = require('./routes/redisRoute');
const userRoute = require("./routes/userRoute");
const reportRoute = require("./routes/reportRoute");
const logRoutes = require('./routes/logRoute')

app.use('/auth', authRoutes);
app.use("/search", projectRoute) 
app.use("/sentiment", sentimentRoute) 
app.use("/cache", redisRoute) 
app.use("/users", userRoute)
app.use("/reports", reportRoute)
app.use('/logs', logRoutes)

// Server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`)
})
