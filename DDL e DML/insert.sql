
DELETE FROM relatorio_diario;


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

INSERT INTO relatorio_diario

SELECT *
FROM tb_acum
;

SELECT * FROM relatorio_diario;