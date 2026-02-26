-- Saldo de pontos acumulado de cada usuário

WITH tb_cliente_dia AS (
SELECT 
    idCliente,
    substr(DtCriacao,1,10) AS dtDia,
    SUM (QtdePontos) AS totalPontos,
    SUM(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) AS pontosPos
FROM transacoes
GROUP BY idCliente, dtDia
)

SELECT *,
    SUM(totalPontos) OVER(PARTITION BY idCliente ORDER BY dtDia) AS SaldoPontos,
    SUM(pontosPos) OVER (PARTITION BY idCliente ORDER BY dtDia) AS TotalPontosPos
FROM tb_cliente_dia