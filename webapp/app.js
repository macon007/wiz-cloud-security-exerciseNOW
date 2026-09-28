const express = require("express");
const { MongoClient } = require("mongodb");
const os = require("os");

const app = express();
const port = process.env.PORT || 3000;

const mongoUri = process.env.MONGO_URI;
const mongoDb = process.env.MONGO_DB || "wizapp";

let client;
let db;

async function connectMongo() {
  if (!mongoUri) {
    console.log("MONGO_URI is not configured");
    return;
  }

  client = new MongoClient(mongoUri);
  await client.connect();
  db = client.db(mongoDb);
  console.log("Connected to MongoDB");
}

app.get("/", async (req, res) => {
  let data = [];

  try {
    if (db) {
      data = await db.collection("test").find({}).toArray();
    }
  } catch (err) {
    console.error("MongoDB error:", err.message);
  }

  res.json({
    application: "Wiz Cloud Security Exercise",
    status: "running",
    hostname: os.hostname(),
    mongodb: db ? "connected" : "not connected",
    data
  });
});

app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

app.listen(port, async () => {
  console.log(`Web app listening on port ${port}`);

  try {
    await connectMongo();
  } catch (err) {
    console.error("MongoDB connection failed:", err.message);
  }
});
