SELECT
  f.nome_fabricante,
  COUNT(vi.cod_item) AS "Total Carros Vendidos",
  SUM(vi.preco_venda) AS "Valor Total Vendido",
  ROUND(AVG(vi.preco_venda), 2) AS "Ticket Médio por venda"
FROM tb_fabricante f
JOIN tb_modelo m ON f.cod_fabricante = m.cod_fabricante
JOIN tb_carro c ON m.cod_modelo = c.cod_modelo
JOIN tb_venda_item vi ON c.cod_carro = vi.cod_carro
GROUP BY f.nome_fabricante
ORDER BY 3 DESC;