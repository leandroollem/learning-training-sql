SELECT *
FROM transacoes
WHERE STRFTIME('%w',DATETIME(SUBSTR(DtCriacao, 1, 19))) IN ('6', '0')
