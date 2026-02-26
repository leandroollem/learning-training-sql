-- Do início ao fim do nosso curso (2025/08/25 a 2025/08/29), 
-- quantos clientes assinaram a lista de presença?

SELECT
    COUNT(DISTINCT c.idCliente),
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
    AND t.DtCriacao BETWEEN '2025-08-25' AND '2025-08-29'
