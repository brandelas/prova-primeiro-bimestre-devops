CREATE TABLE IF NOT EXISTS reservas (
    id SERIAL PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    data_reserva DATE NOT NULL,
    horario TIME NOT NULL,
    quantidade_pessoas INTEGER NOT NULL CHECK (quantidade_pessoas > 0),
    observacoes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
