-- Quais clientes assinaram a lista de presença no dia 2025/08/25?

SELECT
    c.idCliente,
    p.DescNomeProduto,
    t.DtCriacao
FROM clientes c
LEFT JOIN transacoes t
    ON c.IdCliente = t.idCliente
LEFT JOIN transacao_produto tp
    ON t.IdTransacao = tp.IdTransacao
LEFT JOIN produtos p 
    ON tp.IdProduto = p.IdProduto
WHERE p.DescNomeProduto = 'Lista de presença'
    AND t.DtCriacao LIKE '2025-08-25%'