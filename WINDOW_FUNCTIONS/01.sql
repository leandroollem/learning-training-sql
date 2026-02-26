/* Quantidade de interações durante 
o curso (total) de forma acumulada*/

WITH tb_sumarioDias AS (
    SELECT
    substr(DtCriacao, 1, 10) AS dtDia,
    COUNT(IdTransacao) AS qtTransacoes
FROM transacoes
WHERE DtCriacao BETWEEN '2025-08-25' AND '2025-08-30'
GROUP BY dtDia
)

SELECT
    *,
    SUM(qtTransacoes) OVER (ORDER BY dtDia) AS  qtdeTrasacaoAcumuluada
FROM tb_sumarioDias