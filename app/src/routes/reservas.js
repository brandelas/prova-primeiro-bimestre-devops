const express = require("express");
const pool = require("../db");

const router = express.Router();

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
  const {
    nome_cliente,
    data_reserva,
    horario,
    quantidade_pessoas,
    observacoes,
  } = req.body;

  if (!nome_cliente || !data_reserva || !horario || !quantidade_pessoas) {
    return res.status(400).json({
      error: "Campos obrigatórios não informados",
    });
  }

  if (quantidade_pessoas <= 0) {
    return res.status(400).json({
      error: "A quantidade de pessoas deve ser maior que zero",
    });
  }

  try {
    const result = await pool.query(
      `UPDATE reservas
       SET nome_cliente = $1,
           data_reserva = $2,
           horario = $3,
           quantidade_pessoas = $4,
           observacoes = $5,
           updated_at = CURRENT_TIMESTAMP
       WHERE id = $6
       RETURNING *`,
      [
        nome_cliente,
        data_reserva,
        horario,
        quantidade_pessoas,
        observacoes || null,
        id,
      ]
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
  const {
    nome_cliente,
    data_reserva,
    horario,
    quantidade_pessoas,
    observacoes,
  } = req.body;

  if (!nome_cliente || !data_reserva || !horario || !quantidade_pessoas) {
    return res.status(400).json({
      error: "Campos obrigatórios não informados",
    });
  }

  if (quantidade_pessoas <= 0) {
    return res.status(400).json({
      error: "A quantidade de pessoas deve ser maior que zero",
    });
  }

  try {
    const result = await pool.query(
      `INSERT INTO reservas
        (nome_cliente, data_reserva, horario, quantidade_pessoas, observacoes)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING *`,
      [
        nome_cliente,
        data_reserva,
        horario,
        quantidade_pessoas,
        observacoes || null,
      ]
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