-- Quantidade de transações Acumuladas ao longo do tempo (diário)?


WITH tb_diario AS (
SELECT
    substr(DtCriacao,1,10) AS dtDia,
    COUNT(DISTINCT IdTransacao) AS qntdTransacao
FROM transacoes
GROUP BY dtDia
ORDER BY dtDia
),

tb_acum AS (
SELECT *,
    SUM(qntdTransacao) OVER (ORDER BY dtDia) AS qtdeTransaAcum
FROM tb_diario
)


-- Que dia atingiu o numero de 100k transacoes
SELECT *
FROM tb_acum
WHERE qtdeTransaAcum >= 100000
ORDER BY qtdeTransaAcum ASC
LIMIT 1