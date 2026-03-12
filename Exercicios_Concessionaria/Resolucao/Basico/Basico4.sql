SELECT
  cod_modelo,
  nome_modelo,
  segmento,
  tipo_combustivel,
  ano_inicio
FROM tb_modelo
WHERE fl_nacional = 'S'