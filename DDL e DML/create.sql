
DROP TABLE IF EXISTS relatorio_diario;

CREATE TABLE IF NOT EXISTS relatorio_diario AS

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


SELECT *
FROM tb_acum
;

SELECT * FROM relatorio_diario;