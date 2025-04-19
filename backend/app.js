require("dotenv").config()
const express = require("express")
const app = express()
const PORT = 3000

// Middleware
app.use(express.json())

// Routing
const authRoutes = require('./routes/authRoutes');
const projectRoute = require("./routes/projectRoute");
const sentimentRoute = require('./routes/sentimentRoute');
const redisRoute = require('./routes/redisRoute');
const userRoute = require("./routes/userRoute");
const reportRoute = require("./routes/reportRoute");


app.use('/auth', authRoutes);
app.use("/search", projectRoute) 
app.use("/sentiment", sentimentRoute) 
app.use("/cache", redisRoute) 
app.use("/api/users", userRoute)
app.use("/api/reports", reportRoute)


// Server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`)
})
