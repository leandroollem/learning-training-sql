SELECT
  cod_carro,
  vin,
  cod_modelo,
  ano_fabricacao,
  km,
  preco_tabela,
  cod_loja
FROM tb_carro
WHERE status = 'EM_ESTOQUE'