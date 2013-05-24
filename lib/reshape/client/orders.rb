module Reshape
  class Client
    module Orders
      
      def cart(options={}, raw=false)
        get("/orders/cart/#{api_version}", options, raw)
      end
      
      def add_to_cart(modelId, materialId, quantity, options={}, raw=false)
        options.merge!(
          {
            modelId: modelId,
            materialId: materialId,
            quantity: quantity
          })
        post("/orders/cart/#{api_version}", options, raw)
      end
      
    end
  end
end