SELECT 
*,
CASE
    WHEN qtdePontos < 10 THEN 'Baixo'
    WHEN qtdePontos >= 500 THEN 'Alto'
    ELSE 'Médio'
END AS Sinalizacao

FROM transacoes