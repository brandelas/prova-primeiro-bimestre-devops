const express = require("express");
const pool = require("../db");

const router = express.Router();

const normalizeReservaPayload = (body = {}) => ({
  cliente: typeof body.cliente === "string" ? body.cliente.trim() : body.cliente,
  data: body.data,
  status: typeof body.status === "string" ? body.status.trim() : body.status,
});

router.get("/", async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM reservas ORDER BY id"
    );

    res.json(result.rows);
  } catch (error) {
    console.error("Erro ao buscar reservas:", error);
    res.status(500).json({
      error: "Erro interno ao buscar reservas",
    });
  }
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query(
      "SELECT * FROM reservas WHERE id = $1",
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Reserva não encontrada",
      });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error("Erro ao buscar reserva:", error);
    res.status(500).json({
      error: "Erro interno ao buscar reserva",
    });
  }
});

router.put("/:id", async (req, res) => {
  const { id } = req.params;
  const { cliente, data, status } = normalizeReservaPayload(req.body);

  if (!cliente || !data || !status) {
    return res.status(400).json({
      error: "Campos obrigatórios não informados",
    });
  }

  try {
    const result = await pool.query(
      `UPDATE reservas
       SET cliente = $1,
           data = $2,
           status = $3
       WHERE id = $4
       RETURNING *`,
      [cliente, data, status, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Reserva não encontrada",
      });
    }

    res.json(result.rows[0]);
  } catch (error) {
    console.error("Erro ao atualizar reserva:", error);
    res.status(500).json({
      error: "Erro interno ao atualizar reserva",
    });
  }
});

router.delete("/:id", async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query(
      "DELETE FROM reservas WHERE id = $1 RETURNING *",
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        error: "Reserva não encontrada",
      });
    }

    res.status(204).send();
  } catch (error) {
    console.error("Erro ao excluir reserva:", error);
    res.status(500).json({
      error: "Erro interno ao excluir reserva",
    });
  }
});

router.post("/", async (req, res) => {
  const { cliente, data, status } = normalizeReservaPayload(req.body);

  if (!cliente || !data || !status) {
    return res.status(400).json({
      error: "Campos obrigatórios não informados",
    });
  }

  try {
    const result = await pool.query(
      `INSERT INTO reservas (cliente, data, status)
       VALUES ($1, $2, $3)
       RETURNING *`,
      [cliente, data, status]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error("Erro ao criar reserva:", error);
    res.status(500).json({
      error: "Erro interno ao criar reserva",
    });
  }
});

module.exports = router;