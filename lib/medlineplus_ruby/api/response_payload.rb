module MedlineplusRuby
  module API
    class ResponsePayload

      RESPONSE_ERROR_NOPARSE = 'Unable to parse response from NLM API.'.freeze

      def initialize
      end

      def respond(api_response_body, api_response_status)
        formatted_response = {
          success: false,
          errors: [],
          data_requested: nil,
          data: [],
          response_raw: api_response_body
        }

        begin
          parsed_body = JSON.parse api_response_body, symbolize_names: true
        rescue JSON::ParserError => e
          formatted_response[:errors] << RESPONSE_ERROR_NOPARSE
        end

        formatted_response.tap do |h|
          h[:success]        = true
          h[:data_requested] = parsed_body[:feed][:subtitle][:_value]
          
          parsed_body[:feed][:entry].each do |entry|
            h[:data] << {
              title:       entry[:title][:_value],
              link:        entry[:link].first[:href],
              description: entry[:summary][:_value]
            }
          end if !!parsed_body[:feed][:entry]
        end if !!parsed_body

        formatted_response
      end

    end
  end
end
