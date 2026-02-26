SELECT
    IdProduto,
    SUM(vlProduto * QtdeProduto)
FROM transacao_produto
GROUP BY IdProduto
ORDER BY 2 DESC LIMIT 1
