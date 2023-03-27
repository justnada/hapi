const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");
const app = express();
const errorHandler = require("./middleware/error");
const routes = require("./routes");
const db = require("./database/hapi");

app.use(cors());
app.use(helmet());
app.use(morgan("dev"));
app.use(express.json({ limit: "50mb" }));

app.get("/", async (req, res) => {
  res.send("Hello World!");
});

for (const idx in routes) {
  app.use("/api", routes[idx]);
}

try {
  db.authenticate();
  console.log("Connection has been established successfully.");
} catch (error) {
  console.error("Unable to connect to the database:", error);
}

app.use(errorHandler);

app.use((req, res, next) => {
  res.status(404).json({
    code: "2",
    error: "Error : Route Not Found ",
  });
});

module.exports = app;
