const express = require("express");
const cors = require("cors");
require("dotenv").config();


const authRoutes = require("./routes/authRoutes");

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/auth", authRoutes);

app.get("/", (req, res) => res.send("Auth Service is running"));

app.listen(process.env.PORT, () => {
  console.log(`Auth Service running on port ${process.env.PORT}`);
});
