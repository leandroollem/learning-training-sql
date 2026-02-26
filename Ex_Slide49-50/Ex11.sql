-- QUEM INICIOU O CURSO NO PRIMEIRO DIA, EM MÉDIA ASSISTIU QUANTAS AULAS?



-- Quem participou da primeira aula
WITH tb_primeirodia AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),


-- Quem participou do curso inteiro
tb_diascurso AS (
    SELECT DISTINCT
        idCliente,
        substr(DtCriacao, 1, 10) AS presenteDia
    FROM transacoes
    WHERE DtCriacao BETWEEN '2025-08-25' AND '2025-08-30'

    ORDER BY idCliente, presenteDia
),

-- Contando quantas vezes quem participou do primeiro dia, voltou
tb_clientedia AS (

SELECT
    t1.idCliente,
    COUNT(t2.presenteDia) AS QtDias
FROM tb_primeirodia t1
LEFT JOIN tb_diascurso t2 
    ON t1.idCliente = t2.idCliente
GROUP BY t1.idCliente
)
-- Calculando a média
SELECT AVG(QtDias)
FROM tb_clientedia