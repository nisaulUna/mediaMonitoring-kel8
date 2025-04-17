require("dotenv").config()
const express = require("express")
const app = express()
const PORT = 3000

// Middleware
app.use(express.json())

// Routing
const mainPageRoute = require("./routes/mainPageRoute")
const authRoutes = require('./routes/authRoutes');
app.use("/", mainPageRoute) 
app.use('/auth', authRoutes);

// Server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`)
})
