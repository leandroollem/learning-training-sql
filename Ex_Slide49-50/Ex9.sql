-- Dos clientes que começaram SQL no primeiro dia, quantos chegaram ao 5o dia?

SELECT COUNT(DISTINCT idCliente)
FROM transacoes t
WHERE t.idCliente IN (
    SELECT 
        DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'

)
AND substr(t.DtCriacao, 1, 10) = '2025-08-29';



SELECT COUNT(DISTINCT idCliente)
FROM transacoes t
WHERE t.idCliente IN (
    SELECT 
        DISTINCT idCliente
    FROM transacoes
    WHERE DtCriacao LIKE '2025-08-25%'

)
AND DtCriacao LIKE '2025-08-29%';








SELECT 
        COUNT(DISTINCT idCliente)
    FROM transacoes
    WHERE DtCriacao LIKE '2025-08-25%';