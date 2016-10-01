Rails.application.routes.draw do
  devise_for :usuarios, class_name: 'Seguridad::Usuario'

  # You can have the root of your site routed with "root"
  root 'home#index'

  namespace :facturacion do
    get 'pedidos/index'
    get 'pedidos_fecha/index'

    get 'cuentas_activas/detalle'
    get 'cuentas_activas/index'

    get 'cuentas_por_cliente/detalle'
    get 'cuentas_por_cliente/index'
  end

  namespace :ventas do
    get 'venta_por_cliente/index'
    get 'venta_por_cliente/detalle'

    resources :pedidos
    post 'pedidos/crear_detalle'
    post 'pedidos/borrar_detalle'
    post 'pedidos/rpt_lista_pedidos'
    post 'pedidos/rpt_orden_trabajo'
    post 'pedidos/credito'
    post 'pedidos/contado'

    resources :agrupador_clientes
    resources :clientes
  end

  namespace :inventario do
    resources :producto_detalles
    resources :productos
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
