module Reshape
  class Client
    module Models
      
      def models(options={}, raw=false)
        get("/models/#{api_version}", options, raw)
      end
      
      def model(id, options={}, raw=false)
        get("/models/#{id}/#{api_version}", options, raw)
      end
      
      def add_model(file, name, rights, terms, options={}, raw=false)
        post("/models/#{api_version}", options.merge(file: file, fileName: name, hasRightsToModel: rights, acceptTermsAndConditions: terms), raw)
      end
      
      def delete_model(id, options={}, raw=false)
        delete("/model/#{id}/#{api_version}", options, raw)
      end
      
      def model_info(id, options={}, raw=false)
        get("/models/#{id}/info/#{api_version}", options, raw)
      end
      
      def update_model_info(id, options={}, raw=false)
        put("/models/#{id}/info/#{api_version}", options, raw)
      end
      
      def add_model_file(id, file, name, rights, terms, options={}, raw=false)
        post("/models/#{id}/files/#{api_version}", options.merge(file: file, fileName: name, hasRightsToModel: rights, acceptTermsAndConditions: terms), raw)
      end
      
      def model_file_by_version(id, fileVersion, options={}, raw=false)
        get("/models/#{id}/files/#{fileVersion}/v1")
      end
      
      def add_model_photo(id, file, options={}, raw=false)
        post("/models/#{id}/photos/#{api_version}")
      end
      
    end
  end
end
