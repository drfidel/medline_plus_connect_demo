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
    { descriptions: @diagnosis_code, message: MESSAGE_INVALID }
  end

  # Makes ICD-10 API call, and returns result payload in `Result` Data Transfer
  #  Object.
  def perform
    client          = MedlineplusConnectApiClient.new diagnosis_code: @diagnosis_code
    client_response = JSON.parse client.get_code_description, symbolize_names: true

    if client_response
      if client_response[:feed].present? && client_response[:feed][:entry].present?
        Result::Success.new descriptions: client_response[:feed][:entry], message: MESSAGE_SUCCESS
      else
        Result::Success.new
      end
    else
      Result::Failure.new errors: ERROR_NO_RESPONSE
    end
  end
end
