json.array!(@ventas_pedidos) do |ventas_pedido|
  json.extract! ventas_pedido, :id, :fecha, :cliente_id
  json.url ventas_pedido_url(ventas_pedido, format: :json)
end
