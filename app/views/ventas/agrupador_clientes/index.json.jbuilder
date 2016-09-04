json.array!(@ventas_agrupador_clientes) do |ventas_agrupador_cliente|
  json.extract! ventas_agrupador_cliente, :id, :nombre, :descripcion
  json.url ventas_agrupador_cliente_url(ventas_agrupador_cliente, format: :json)
end
