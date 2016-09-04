json.array!(@ventas_clientes) do |ventas_cliente|
  json.extract! ventas_cliente, :id, :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :sexo, :cedula, :fecha_nacimiento
  json.url ventas_cliente_url(ventas_cliente, format: :json)
end
