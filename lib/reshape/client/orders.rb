module Reshape
  class Client
    module Orders

      def orders(options={}, raw=false)

        get("/orders/#{api_version}", options, raw)
      end

      def add_order(order_details, options={}, raw=false)

        # order deatils
        #firstName
        #lastName
        #country
        #state
        #city
        #address1
        #address2
        #address3
        #zipCode
        #phoneNumber
        #items
        #incentives
        #paymentVerificationId
        #paymentMethod
        #shippingOption
        #metadata

        # just a stub
        #post("/orders/#{api_version}", options.merge(order_details), raw)
        false
      end

      def order(id, options={}, raw=false)
        get("/orders/#{id}/#{api_version}", options, raw)
      end

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
