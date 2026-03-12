SELECT
  status,
  COUNT (cod_carro) as "Total Carros"
FROM tb_carro
GROUP BY status
ORDER BY COUNT(cod_carro) DESC