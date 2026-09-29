const path = require("path");
require("dotenv").config({
  path: path.resolve(__dirname, "../../.env"),
});

const express = require("express");
const reservasRoutes = require("./routes/reservas");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get("/health", (req, res) => {
  res.status(200).json({ status: "ok" });
});

app.use("/reservas", reservasRoutes);

app.listen(PORT, () => {
  console.log(`API rodando na porta ${PORT}`);
});
