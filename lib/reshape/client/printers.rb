module Reshape
  class Client
    module Printers
      
      def printers(options={}, raw=false)
        get("/printers/#{api_version}", options, raw)
      end
      
      def printer(id, options={}, raw=false)
        get("/printers/#{id}/#{api_version}", options, raw)
      end
      
    end
  end
end