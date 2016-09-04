json.array!(@ventas_pedido_detalles) do |ventas_pedido_detalle|
  json.extract! ventas_pedido_detalle, :id, :pedido_id, :producto_id, :cantidad, :precio
  json.url ventas_pedido_detalle_url(ventas_pedido_detalle, format: :json)
end
