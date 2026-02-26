-- Qual o dia com maior engajamento de cada que iniciou o curso no dia01
-- A pessoa que entrou no dia 01, qual foi o dia que mais ela fez mais 
-- transações

WITH tb_dia01 AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE DtCriacao LIKE '2025-08-25%'
),

tb_dia_cliente AS (
    SELECT 
        t1.idCliente,
        substr(t2.DtCriacao, 1, 10) AS dtDia,
        COUNT(*) AS qtdeInteracoes
    FROM tb_dia01 t1
    LEFT JOIN transacoes t2
        ON t1.idCliente = t2.idCliente
    AND DtCriacao BETWEEN '2025-08-25' AND '2025-08-30'
    GROUP BY t1.idCliente, dtDia
    ORDER BY qtdeInteracoes DESC
),

tb_rn AS (
    SELECT
    *,
    -- Cria uma coluna com os numero das linhas particionadas por cliente, em ordem descrecente
    -- de interações, e pra desempate, vai pela crescente de dia 
    ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtdeInteracoes DESC, dtDia) AS rn
FROM tb_dia_cliente
)

SELECT *
FROM tb_rn
WHERE rn = 1
