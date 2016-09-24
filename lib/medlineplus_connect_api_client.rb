class MedlinePlusConnectApiError < StandardError; end;

class MedlinePlusConnectApiClient
  # Medical coding system identifiers.
  SYSTEM_ICD10 = '2.16.840.1.113883.6.90'.freeze
  SYSTEM_ICD9  = '2.16.840.1.113883.6.103'.freeze
  # Acceptable API response types.
  RESPONSE_JSON = 'application/json'.freeze
  RESPONSE_XML  = 'text/xml'.freeze
  # Cache prefixes.
  CODE_CACHE_PREFIX = 'MedlinePlusConnect-diagnosis_code-'.freeze

  @@api_url = 'https://apps.nlm.nih.gov/medlineplus/services/mpconnect_service.cfm'

  def initialize(options = {})
    @system         = options[:system] || MedlinePlusConnectApi::SYSTEM_ICD10
    @response_type  = options[:response_type] || MedlinePlusConnectApi::RESPONSE_JSON
    @diagnosis_code = options[:diagnosis_code] || ''
    @no_caching     = options[:no_caching] || false
  end

  def get_code_description
    response = Rails.cache.fetch code_cache_key(@diagnosis_code), expires_in: 12.hours, force: @no_caching do
      RestClient.get @@api_url, {
        params: {
          'mainSearchCriteria.v.cs' => @system,
          'mainSearchCriteria.v.c'  => @diagnosis_code,
          'knowledgeResponseType'   => @response_type } }
    end

    # MedlinePlus Connect is rate limited to 100 req/minute. Once this limit is
    #  reached, service will not be restored for 300 seconds, or whenever the 
    #  request rate falls below 100/min, whichever is longer.
    if false # TODO: Check for failures and/or rate limitations, and throw an exception when one occurs.
      Rails.cache.write(code_cache_key(diagnosis_code), response, expires_in: 300) unless @no_caching
      raise MedlinePlusConnectApiError # TODO GET ERROR MESSAGES
    end

    response
  end

  protected

    # Generate a cache key for storing the result of looking up diagnosis
    #  code description text.
    def code_cache_key(diagnosis_code)
      @code_cache_key ||= CODE_CACHE_PREFIX.to_s + diagnosis_code.to_s # TODO: Unsafe to memoize this?
    end
end
