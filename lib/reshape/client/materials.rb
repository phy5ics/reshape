module Reshape
  class Client
    module Materials
      
      def get_materials(options={}, raw=false)
        get("/materials/#{api_version}", options, raw)
      end
      
    end
  end
end