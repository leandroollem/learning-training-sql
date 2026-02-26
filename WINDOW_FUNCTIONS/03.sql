/* De quanto em quanto tempo, as pessoas voltam a assitir? 
 É recorrencia e não frequência */

WITH cliente_dia AS (
SELECT 
    DISTINCT 
    idCliente,
    substr(DtCriacao,1,10) AS dtDia
FROM transacoes
WHERE substr(DtCriacao,1,4) = '2025'
ORDER BY idCliente, dtDia
),

tb_lag AS (
SELECT *,
    LAG (dtDia) OVER (PARTITION BY idCliente ORDER BY dtDia) AS lag_dia
FROM cliente_dia
),

tb_dtDiff AS (
        SELECT *,
        julianday(dtDia) - julianday(lag_dia) AS diferenca_dia
FROM tb_lag
),

avg_cliente AS (
    SELECT
-- NULL = não voltou
    idCliente,
    AVG(diferenca_dia) AS avg_dia
FROM tb_dtDiff
GROUP BY idCliente
)

SELECT AVG(avg_dia) FROM avg_cliente