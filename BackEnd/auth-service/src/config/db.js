const { Pool } = require("pg");
const dotenv = require("dotenv");

// Force correct .env file based on NODE_ENV
const envPath = process.env.NODE_ENV === "test" ? ".env.test" : ".env";
dotenv.config({ path: envPath });

// Make sure password is treated as string explicitly
const pool = new Pool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  user: process.env.DB_USER,
  password: String(process.env.DB_PASS), // ✅ ensures password is string
  database: process.env.DB_NAME,
});

module.exports = pool;
