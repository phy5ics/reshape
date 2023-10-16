require 'countries/global'

  
module Reshape
  class Client
    module Orders

      # get an order by id
      def order(id, options={}, raw=false)
        get("/orders/#{id}/#{api_version}", options, raw)
      end

      # get a list of orders
      def orders(options={}, raw=false)

        get("/orders/#{api_version}", options, raw)
      end

      def add_order(order_details, options={}, raw=false)

        # check country code
        # https://shopify.dev/docs/api/storefront/2023-04/enums/countrycode
        #c = ISO3166::Country.find_country_by_alpha2("FR")

        # order deatils
        #testMode (optional field, use value 1 to void the order placement)
        #firstName
        #lastName
        #country
        #state
        #city
        #address1
        #address2 (optional)
        #address3 (optional)
        #zipCode
        #phoneNumber
        #items
        #
        #{
        #   "type":"object",
        #   "description":"Item in your order",
        #   "properties":{
        #      "modelId":{
        #         "type":"int",
        #         "description":"Model id"
        #      },
        #      "materialId":{
        #         "type":"int",
        #         "description":"Material id"
        #      },
        #      "quantity":{
        #         "type":"int",
        #         "description":"Quantity of models in this material"
        #      }
        #   }
        #}
        #
        #incentives
        #{
        # "type":"string",
        # "description":"Incentive code"
        #}
        #paymentVerificationId
        #paymentMethod : "credit_card"
        #shippingOption : "Cheapest"
        #manufacturingSpeed : "Economy"
        #refNumber:
        #metadata:

        options.merge!(order_details)
        post("/orders/#{api_version}", options, raw)

        false
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
