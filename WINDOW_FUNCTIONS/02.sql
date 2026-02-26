/*  Fazendo por cliente   */

WITH tb_clienteDia AS (
    SELECT
    idCliente,
    substr(DtCriacao, 1, 10) AS dtDia,
    COUNT(IdTransacao) AS qtTransacoes
FROM transacoes
WHERE DtCriacao BETWEEN '2025-08-25' AND '2025-08-30'
GROUP BY IdCliente, dtDia
),

tb_lag AS (
    SELECT *,
    SUM(qtTransacoes) OVER (PARTITION BY idCliente ORDER BY dtDia) AS acum,
    LAG(qtTransacoes) OVER (PARTITION BY idCliente ORDER BY dtDia) AS lagteste
FROM tb_clienteDia
)

SELECT *,
    -- Mede tendência, se o engajamento aumentou ou diminuiu
    1.* qtTransacoes / lagteste

FROM tb_lag