SELECT 
  cod_venda,
  dt_venda,
  forma_pagto,
  total_venda,
  cod_cliente
FROM tb_venda
WHERE dt_venda between '2025-02-01' AND '2025-02-29'