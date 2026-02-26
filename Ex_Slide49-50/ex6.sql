/* Quantidade de usuários cadastrados 
(absoluto e acumulado) ao longo do tempo? */


WITH tb_dia_cliente AS (
    SELECT 
    substr(DtCriacao,1,10) AS dtDia,
    COUNT(DISTINCT idCliente) AS qtdCliente
FROM clientes
GROUP BY dtDia
)

-- tb_acum AS (
SELECT
    *,
    SUM(qtdCliente) OVER (ORDER BY dtDia) AS qtdClienteAcum
FROM tb_dia_cliente
-- )

-- SELECT *
-- FROM tb_acum
-- WHERE qtdClienteAcum >= 2000
-- ORDER BY dtDia
-- LIMIT 1
