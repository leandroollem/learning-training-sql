SELECT
  t1.cod_carro,
  t1.vin,
  t2.nome_modelo,
  t3.nome_fabricante,
  t1.status
FROM tb_carro t1
JOIN tb_modelo t2
  ON t1.cod_modelo = t2.cod_modelo
JOIN tb_fabricante t3
  ON t2.cod_fabricante = t3.cod_fabricante