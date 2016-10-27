require 'medlineplus_ruby/error'
require 'rest-client'

module MedlineplusRuby
  module API
    # MedlinePlus Connect is rate limited to 100 req/minute. Once this limit is
    #  reached, service will not be restored for 300 seconds, or whenever the 
    #  request rate falls below 100/min, whichever is longer.
    class Request

      # Base location from which to make API requests.
      API_URI = 'https://apps.nlm.nih.gov/medlineplus/services/mpconnect_service.cfm'.freeze

      def get_request(req_params = {})
        
        response = RestClient.get API_URI, { params: req_params }

        # TODO: Check for failures and/or rate limitations, and throw an exception
        #  when one occurs. Provide an error message, or extract something 
        #  meaningful from the response if provided.
        unless response && response.code < 400
          raise MedlineplusRuby::Error, 'MedlinePlus Connect API fail'
        end        

        response.body
      end
      
    end
  end
end
