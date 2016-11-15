require 'medlineplus_ruby/api/response_message'

module MedlineplusRuby
  module API
    class ResponsePayload

      def initialize
      end

      # Currently only supports 'application/json' responses.
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
          formatted_response[:errors] << MedlineplusRuby::API::ResponseMessage::ERROR_NO_PARSE
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
