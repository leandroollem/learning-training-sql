SELECT 
    idCliente,
    SUM(QtdePontos)
FROM transacoes
WHERE DtCriacao LIKE '2025-05%' 
    AND qtdePontos > 0
GROUP BY idCliente
ORDER BY SUM(QtdePontos) DESC LIMIT 1