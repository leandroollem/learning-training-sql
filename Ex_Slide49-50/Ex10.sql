-- Como foi a curva de Churn do Curso de SQL?
-- Churn: Cancelamentos (1 - Retensão)
-- Retensão: 1 - Churn

-- Não é a maneira mais correta, pois não garante que os
-- 304 estavam dentro dos 452 iniciais
-- SELECT
--     substr(DtCriacao,1,10) AS dtDia,
--     COUNT(DISTINCT idCliente)
-- FROM transacoes

-- WHERE DtCriacao BETWEEN '2025-08-25' AND '2025-08-30'
-- GROUP BY dtDia;


-- Clientes que estavam no primeiro dia
WITH tb_clientesD1 AS (
    SELECT DISTINCT IdCliente
FROM transacoes
WHERE DtCriacao LIKE '2025-08-25%'
)

SELECT
    substr(t2.DtCriacao,1,10) AS dtDia,
    COUNT(DISTINCT t1.idCliente) AS qtdeCLiente,
    1.* COUNT(DISTINCT t1.idCliente) / (SELECT COUNT(*) FROM tb_clientesD1),
    1 - 1.* COUNT(DISTINCT t1.idCliente) / (SELECT COUNT(*) FROM tb_clientesD1) AS pctChurn
FROM tb_clientesD1 t1
LEFT JOIN transacoes t2
    ON t1.idCliente = t2.idCliente
WHERE t2.DtCriacao BETWEEN '2025-08-25' AND '2025-08-30'
GROUP BY dtDia;

-- Mostra o dia, quantidade de clientes, e a proporção/
-- porcentagem de rentenção de pessoas no curso

-- 54% de churn