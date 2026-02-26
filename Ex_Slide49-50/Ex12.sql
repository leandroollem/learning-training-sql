-- Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?
-- Quem são os clientes de janeiro e cruzar com qm assistiu o curso

-- Direto
WITH tb_clientesJan AS (
SELECT DISTINCT idCliente
FROM transacoes
WHERE DtCriacao LIKE '%-01-%'
)

SELECT 
    COUNT(DISTINCT t1.idCliente),
    COUNT(DISTINCT t2.idCliente)
FROM tb_clientesJan t1
LEFT JOIN transacoes t2
    ON t1.idCliente = t2.idCliente
AND t2.DtCriacao BETWEEN '2025-08-25' AND '2025-08-30';

-- Passo a Passo (jeito mais fácil)

WITH tb_clientesJan AS (
SELECT DISTINCT idCliente
FROM transacoes
WHERE DtCriacao LIKE '%-01-%'
),

tb_clientescurso AS (
SELECT DISTINCT idCliente
FROM transacoes
WHERE DtCriacao BETWEEN '2025-08-25' AND '2025-08-30'
)

SELECT
    COUNT(DISTINCT t1.idCliente) AS clienteJaneiro,
    COUNT(DISTINCT t2.idCliente) AS cleintecurso
FROM tb_clientesJan t1
LEFT JOIN tb_clientescurso t2
    ON t1.idCliente = t2.idCliente;
