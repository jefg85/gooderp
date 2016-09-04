json.array!(@inventario_producto_detalles) do |inventario_producto_detalle|
  json.extract! inventario_producto_detalle, :id, :producto_id, :nombre, :descripcion
  json.url inventario_producto_detalle_url(inventario_producto_detalle, format: :json)
end
