-- Clientes mais antigos, tem mais frequência de transação?

SELECT
    CASE
        WHEN c.DtCriacao LIKE '2024%' THEN 'Novo'
        ELSE 'Antigo'
    END AS classificacao_cliente,
    COUNT(t.IdTransacao)  
FROM clientes c
LEFT JOIN transacoes t  
    ON c.idCliente = t.idCliente
GROUP BY classificacao_cliente
ORDER BY COUNT(t.IdTransacao) DESC;


