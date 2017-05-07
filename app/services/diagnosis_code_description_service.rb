# Provides a description for an ICD-10 diagnosis code.
# Usage: evoke `DiagnosisCodeDescriptorService#perform('code')` method with a
#  value representing a medical diagnosis code.
#  e.g., `response = DiagnosisCodeDescriptorService.perform('J01.01')`.
# See https://github.com/envato/aldous for full documentation.
class DiagnosisCodeDescriptionService < Aldous::Service
  include ServiceMessages

  attr_reader :diagnosis_code
  attr_reader :message

  def initialize(diagnosis_code)
    @diagnosis_code = diagnosis_code
  end

  # Default value to return if no data is provided to the `Result` Data
  #  Transfer Object, or if an exception is raised during the `#perform` call.
  def default_result_data
    { descriptions: [], message: self.class::MESSAGE_INVALID }
  end

  # Makes ICD-10 API call, and returns result payload in `result` Data Transfer
  #  Object.
  def perform
    client          = MedlineplusRuby::Client.new
    client_response = client.description_data_for_code @diagnosis_code

    # Return the descriptions associated with the given diagnosis code, or
    #  return an empty response with the default 'invalid error code'
    #  message.
    # An invalid code is still a successful response from the API,  thus
    #  `Aldous::Service::Result::Success` is the expected response, and not
    #  a fail.
    if client_response && client_response[:success].present?
      if client_response[:data].present? && (client_response[:data].length > 0)
        Result::Success.new descriptions: client_response[:data], message: self.class::MESSAGE_SUCCESS
      else
        Result::Success.new
      end
    else
      Result::Failure.new errors: Aldous::Errors::UserError.new(self.class::ERROR_NO_RESPONSE)
    end
  end

end
