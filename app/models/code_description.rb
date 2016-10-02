# Handles retrieval of medical descriptions associated with a diagnosis code.
class CodeDescription
  include ActiveModel::Model
  include DiagnosisCodeHelper
  
  attr_accessor :code, :description_data
end
