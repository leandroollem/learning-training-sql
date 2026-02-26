-- FEATURE STORE


WITH tb_transacoes AS (
    SELECT 
        idCliente,
        IdTransacao,
        qtdePontos,
        DATETIME(substr(DtCriacao,1,19)) AS dtCriacao,
        julianday('2025-06-01') - julianday(substr(dtCriacao,1,10)) AS dtDiff,
        CAST (strftime('%H', substr(dtCriacao,1,19)) AS INTEGER) AS dtHora
    FROM transacoes 
    WHERE dtCriacao < '2025-06-01'
),

tb_cliente AS (
    SELECT 
        idCliente,
        DATETIME(substr(DtCriacao,1,19)) AS dtCriacao,
        julianday('2025-06-01') - julianday(substr(dtCriacao,1,10)) AS idadeBase
    FROM clientes
),

tb_sumario_transacoes AS (
    SELECT
        idCliente,
        COUNT(IdTransacao) AS qntdTransacoesVida,
        COUNT(CASE WHEN dtDiff <= 56 THEN IdTransacao END) AS qtdeTransacoesD56,
        COUNT(CASE WHEN dtDiff <= 28 THEN IdTransacao END) AS qtdeTransacoesD28,
        COUNT(CASE WHEN dtDiff <= 14 THEN IdTransacao END) AS qtdeTransacoesD14,
        COUNT(CASE WHEN dtDiff <= 7 THEN IdTransacao END) AS qtdeTransacoesD7,

        MIN(dtDiff) AS diasUltimaInteracao,

        SUM(qtdePontos) as saldoPontos,

        SUM(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END) AS qtdePontosPosVida,

        SUM (CASE WHEN qtdePontos > 0 AND dtDiff <= 56 THEN qtdePontos ELSE 0 END) qtdePontosPos56,
        SUM (CASE WHEN qtdePontos > 0 AND dtDiff <= 28 THEN qtdePontos ELSE 0 END) qtdePontosPos28,
        SUM (CASE WHEN qtdePontos > 0 AND dtDiff <= 14 THEN qtdePontos ELSE 0 END) qtdePontosPos14,
        SUM (CASE WHEN qtdePontos > 0 AND dtDiff <=  7 THEN qtdePontos ELSE 0 END) qtdePontosPos7,

        SUM (CASE WHEN qtdePontos < 0 THEN qtdePontos ELSE 0 END) AS qtdePontosNegVida,
        SUM (CASE WHEN qtdePontos < 0 AND dtDiff <= 56 THEN qtdePontos ELSE 0 END) qtdePontosNeg56,
        SUM (CASE WHEN qtdePontos < 0 AND dtDiff <= 28 THEN qtdePontos ELSE 0 END) qtdePontosNeg28,
        SUM (CASE WHEN qtdePontos < 0 AND dtDiff <= 14 THEN qtdePontos ELSE 0 END) qtdePontosNeg14,
        SUM (CASE WHEN qtdePontos < 0 AND dtDiff <=  7 THEN qtdePontos ELSE 0 END) qtdePontosNeg7
    FROM tb_transacoes
    GROUP BY idCliente
),


tb_transacao_produto AS (
    SELECT 
        t1.*,
        t3.DescDescricaoProduto,
        t3.DescCategoriaProduto
    FROM tb_transacoes t1
    LEFT JOIN transacao_produto t2
        ON t1.IdTransacao = t2.IdTransacao
    LEFT JOIN produtos t3
        ON t2.IdProduto = t3.IdProduto 
),

tb_cliente_produto AS (
SELECT
    IdCliente,
    DescDescricaoProduto,
    COUNT(*) AS qtdeVida,
    COUNT(CASE WHEN dtDiff <= 56 THEN IdTransacao END) AS qtde56,
    COUNT(CASE WHEN dtDiff <= 28 THEN IdTransacao END) AS qtde28,
    COUNT(CASE WHEN dtDiff <= 14 THEN IdTransacao END) AS qtde14,
    COUNT(CASE WHEN dtDiff <= 7 THEN IdTransacao END) AS qtde7
FROM tb_transacao_produto
GROUP BY idCliente, DescDescricaoProduto
),

tb_cliente_produto_rn AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtdeVida DESC) AS rnVida,
    ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtde56 DESC) AS rn56,
    ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtde28 DESC) AS rn28,
    ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtde14 DESC) AS rn14,
    ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtde7 DESC) AS rn7
FROM tb_cliente_produto
),


tb_cliente_dia AS (
SELECT
    idCliente,
    strftime('%w',DtCriacao) AS dtDia,
    COUNT(*) AS qtdTransacao
FROM tb_transacoes
WHERE dtDiff <= 28
GROUP BY idCliente, dtDiA
),

tb_cliente_dia_rn AS (
    SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtdTransacao DESC) AS rnDia
FROM tb_cliente_dia
),

tb_join AS (
    SELECT 
        t1.*,
        t2.idadeBase,
        t3.DescDescricaoProduto AS produtoVida,
        t4.DescDescricaoProduto AS produto56,
        t5.DescDescricaoProduto AS produto28,
        t6.DescDescricaoProduto AS produto14,
        t7.DescDescricaoProduto AS produto7,
        COALESCE(t8.dtdia, -1) AS dtDia,
        COALESCE(t9.periodo, 'Sem Informação') AS periodoMaisTransacao28

    FROM tb_sumario_transacoes t1
    LEFT JOIN tb_cliente t2 
        ON t1.idCliente = t2.idCliente

    LEFT JOIN tb_cliente_produto_rn t3
        ON t1.idCliente = t3.idCliente
        AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn t4
        ON t1.idCliente = t4.idCliente
        AND t4.rn56 = 1

    LEFT JOIN tb_cliente_produto_rn t5
        ON t1.idCliente = t5.idCliente
        AND t5.rn28 = 1

    LEFT JOIN tb_cliente_produto_rn t6
        ON t1.idCliente = t6.idCliente
        AND t6.rn14 = 1
    
    LEFT JOIN tb_cliente_produto_rn t7
        ON t1.idCliente = t7.idCliente
        AND t7.rn7 = 1
    
    LEFT JOIN tb_cliente_dia_rn t8
        ON t1.idCliente = t8.IdCliente
        AND t8.rnDia

    LEFT JOIN tb_cliente_periodo_rn t9
        ON t1.idCliente = t9.IdCliente
        AND t9.rnPeriodo = 1
),

tb_cliente_periodo AS (
    SELECT
        idCliente,
        CASE 
            WHEN dtHora BETWEEN 7 AND 12 THEN 'Manhã'
            WHEN dtHora BETWEEN 13 AND 18 THEN 'Tarde'
            WHEN dthora BETWEEN 19 AND 23 THEN 'Noite'
            ELSE 'Madrugada'
        END AS periodo,
        COUNT(*) AS qtdeTransacao
FROM tb_transacoes
WHERE dtDiff <= 28
GROUP BY 1, 2 
),

tb_cliente_periodo_rn AS (
SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtdeTransacao DESC) AS rnPeriodo
FROM tb_cliente_periodo
)

INSERT INTO feature_store_cliente

SELECT 
    '2025-06-01' AS dtRef,
    *,
    1.* qtdeTransacoesD28/qntdTransacoesVida AS engajamento28Vida
FROM tb_join
