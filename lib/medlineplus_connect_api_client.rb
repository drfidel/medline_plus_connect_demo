require 'rest-client'

class MedlineplusConnectApiError < StandardError; end;

class MedlineplusConnectApiClient
  # Medical coding system identifiers.
  SYSTEM_ICD10 = '2.16.840.1.113883.6.90'.freeze
  SYSTEM_ICD9  = '2.16.840.1.113883.6.103'.freeze
  # Acceptable API response types.
  RESPONSE_JSON = 'application/json'.freeze
  RESPONSE_XML  = 'text/xml'.freeze

  # Base location from which to make API requests.
  API_URI = 'https://apps.nlm.nih.gov/medlineplus/services/mpconnect_service.cfm'.freeze

  def initialize(options = {})
    @system         = options[:system] || SYSTEM_ICD10
    @response_type  = options[:response_type] || RESPONSE_JSON
    @diagnosis_code = options[:diagnosis_code] || ''
  end

  def get_code_description
    # MedlinePlus Connect is rate limited to 100 req/minute. Once this limit is
    #  reached, service will not be restored for 300 seconds, or whenever the 
    #  request rate falls below 100/min, whichever is longer.
    response = RestClient.get API_URI, {
      params: {
        'mainSearchCriteria.v.cs' => @system,
        'mainSearchCriteria.v.c'  => @diagnosis_code,
        'knowledgeResponseType'   => @response_type }}

    # TODO: Check for failures and/or rate limitations, and throw an exception
    #  when one occurs.
    if false
      raise MedlinePlusConnectApiError # TODO GET ERROR MESSAGES
    end

    response
  end
end
