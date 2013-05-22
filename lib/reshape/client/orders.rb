module Reshape
  class Client
    module Orders
      
      def get_cart(options={}, raw=false)
        get("/orders/cart/#{api_version}", options, raw)
      end
      
    end
  end
end