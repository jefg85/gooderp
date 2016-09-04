json.array!(@inventario_productos) do |inventario_producto|
  json.extract! inventario_producto, :id, :nombre, :descripcion
  json.url inventario_producto_url(inventario_producto, format: :json)
end
