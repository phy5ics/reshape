module Reshape
  class Client
    module Price
      
      def price(volume, area, x_bound_min, x_bound_max, y_bound_min, y_bound_max, z_bound_min, z_bound_max, options={}, raw=false)
        options.merge!(
          {
            volume: volume,
            area: area,
            xBoundMin: x_bound_min, 
            xBoundMax: x_bound_max,
            yBoundMin: y_bound_min,
            yBoundMax: y_bound_max,
            zBoundMin: z_bound_min,
            zBoundMax: z_bound_max
          })
        post("/price/#{api_version}", options, raw)
      end
      
    end
  end
end