module Reshape
  class Client
    module Orders
      
      def cart(options={}, raw=false)
        get("/orders/cart/#{api_version}", options, raw)
      end
      
      def add_to_cart(model_id, material_id, quantity, options={}, raw=false)
        options.merge!(
          {
            modelId: model_id,
            materialId: material_id,
            quantity: quantity
          })
        post("/orders/cart/#{api_version}", options, raw)
      end
      
    end
  end
end