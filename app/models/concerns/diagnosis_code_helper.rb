# Mixin for interfacing with external diagnosis code lookup service.
module DiagnosisCodeHelper
  extend ActiveSupport::Concern

  def fetch_code_description_data!
    self.description_data = code_description(code) if (respond_to?(:description_data) && respond_to?(:code))
  end

  # Get a description associated with a medical diagnosis code.
  # @param diagnosis_code String 'ICD-10' code
  # @exception DiagnosisCodeServiceError
  # @return String
  def code_description(diagnosis_code)
    result = DiagnosisCodeDescriptionService.perform diagnosis_code

    unless result.success?      
      raise DiagnosisCodeServiceError,
        'Error(s) with diagnosis code description service: ' << result.errors.join(', ').to_s
    end
    
    result.descriptions
  end
end
