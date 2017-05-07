require 'medlineplus_ruby/error'
require 'medlineplus_ruby/api/response_payload'
require 'medlineplus_ruby/api/response_message'
require 'rest-client'

module MedlineplusRuby
  module API
    # MedlinePlus Connect is rate limited to 100 req/minute. Once this limit is
    #  reached, service will not be restored for 300 seconds, or whenever the
    #  request rate falls below 100/min, whichever is longer.
    class Request

      # Base location from which to make API requests.
      API_URI = 'https://apps.nlm.nih.gov/medlineplus/services/mpconnect_service.cfm'.freeze

      # Object to handle resulting response body.
      attr_reader :response_payload

      def self.build
        new ResponsePayload.new
      end

      def initialize(response_payload_handler)
        @response_payload = response_payload_handler
      end

      def get_request(req_params = {})

        response = RestClient.get API_URI, { params: req_params }

        # TODO: Check for failures and/or rate limitations, and return an
        #  appropriate response. Provide an error message, or extract something
        #  meaningful from the response if provided.
        raise MedlineplusRuby::Error,
          MedlineplusRuby::API::ResponseMessage::ERROR_NO_RESPONSE if response.nil? || response.empty?

        @response_payload.respond response.body, response.code
      end

    end
  end
end
