SELECT *
FROM transacao_produto
WHERE IdProduto = (
    SELECT IdProduto
    FROM produtos
    WHERE DescNomeProduto = 'Resgatar Ponei'
)