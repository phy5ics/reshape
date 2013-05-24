module Reshape
  class Client
    module Categories
      
      def categories(options={}, raw=false)
        get("/categories/#{api_version}", options, raw)
      end
      
      def category(id, options={}, raw=false)
        get("/categories/#{id}/#{api_version}", options, raw)
      end
      
    end
  end
end