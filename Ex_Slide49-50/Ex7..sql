-- Qual o dia da semana mais ativo de cada usuário?

WITH tb_cliente_semana AS 
(SELECT 
    idCliente,
    strftime('%w', substr(DtCriacao,1,10)) AS dtDiaSemana,
    COUNT(DISTINCT IdTransacao) AS qtdeTrasacao
FROM transacoes
GROUP BY idCliente, dtDiaSemana
),

tb_rn AS 
(SELECT *,
    ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtdeTrasacao DESC) AS rn
FROM tb_cliente_semana)

SELECT *,
    CASE STRFTIME('%w',DATETIME(SUBSTR(dtDiaSemana, 1, 10)))
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        ELSE 'Saturday'
    END AS dia_semana
FROM tb_rn
WHERE rn = 1