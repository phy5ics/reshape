module Reshape
  class Client
    module Materials
      
      def materials(options={}, raw=false)
        get("/materials/#{api_version}", options, raw)
      end
      
      def material(materialId, options={}, raw=false)
        get("/materials/#{materialId}/#{api_version}", options, raw)
      end
      
    end
  end
end