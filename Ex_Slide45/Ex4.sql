SELECT COUNT(*)
FROM produtos
WHERE DescCategoriaProduto = 'rpg';

SELECT DescCategoriaProduto,
        COUNT(*)
FROM produtos
GROUP BY DescCategoriaProduto;
