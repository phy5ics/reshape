module Reshape
  class Client
    module Materials
      
      def materials(options={}, raw=false)
        get("/materials/#{api_version}", options, raw)
      end
      
      def material(id, options={}, raw=false)
        get("/materials/#{id}/#{api_version}", options, raw)
      end
      
    end
  end
end