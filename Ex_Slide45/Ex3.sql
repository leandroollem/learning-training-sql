SELECT 
    idCliente
FROM transacoes
WHERE DtCriacao LIKE '2024%'
GROUP BY idCliente
ORDER BY COUNT(IdTransacao) DESC LIMIT 1