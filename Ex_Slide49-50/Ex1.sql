-- Quais clientes mais perderam pontos por Lover?

SELECT
    t.idCliente,
    SUM(t.QtdePontos)
FROM transacoes t
LEFT JOIN transacao_produto tp
    ON t.IdTransacao = tp.IdTransacao
LEFT JOIN produtos p 
    ON tp.IdProduto = p.IdProduto
WHERE DescCategoriaProduto = 'lovers'
GROUP BY t.idCliente
ORDER BY t.QtdePontos ASC
LIMIT 10