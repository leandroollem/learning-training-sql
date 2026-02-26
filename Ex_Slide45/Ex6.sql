SELECT 
    CASE STRFTIME('%w',DATETIME(SUBSTR(DtCriacao, 1, 10)))
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        ELSE 'Saturday'
END AS DiaDaSemana,
COUNT(IdTransacao)
FROM transacoes
WHERE DtCriacao LIKE '2025%'
GROUP BY 1
ORDER BY COUNT(IdTransacao) DESC