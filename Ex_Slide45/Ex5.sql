SELECT 
    SUM(qtdePontos),
    COUNT(DISTINCT substr(DtCriacao,1,10)) AS qtdeDiasUnicos,
    SUM(qtdePontos) / COUNT(DISTINCT substr(DtCriacao,1,10)) AS media
FROM transacoes
WHERE QtdePontos > 0;

SELECT
    substr(DtCriacao,1,10) AS dtDia,
    AVG(QtdePontos) AS mediaPontos
FROM transacoes
WHERE QtdePontos > 0
GROUP BY 1
ORDER BY 1 DESC;
