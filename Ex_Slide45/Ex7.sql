SELECT 
    IdProduto,
    SUM(QtdeProduto)
FROM transacao_produto
GROUP BY IdProduto
ORDER BY SUM (QtdeProduto) DESC LIMIT 1