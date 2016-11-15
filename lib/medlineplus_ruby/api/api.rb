require 'medlineplus_ruby/api/code_system'
require 'medlineplus_ruby/api/response_type'
require 'medlineplus_ruby/api/request'

module MedlineplusRuby
  module API

    # Creates a Hash intended for use as a HTTP GET query, in which keys
    #  represent both API endpoints and request parameters for the NLM
    #  Medlineplus Connect API request.
    def description_data_for_code(diagnosis_code, options = {})
      code_description_params = {
        'mainSearchCriteria.v.c'  => diagnosis_code,
        'mainSearchCriteria.v.cs' => (options[:code_system]   || MedlineplusRuby::API::CodeSystem::SYSTEM_ICD10),
        'knowledgeResponseType'   => (options[:response_type] || MedlineplusRuby::API::ResponseType::RESPONSE_JSON)
      }

      MedlineplusRuby::API::Request.build.get_request code_description_params
    end

  end
end
