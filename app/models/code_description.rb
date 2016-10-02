# Handles retrieval of medical descriptions associated with a diagnosis code.
#  E.g., "S11.012" or "J01.01"
class CodeDescription
  include ActiveModel::Model
  include DiagnosisCodeHelper
  
  attr_accessor :code
  attr_reader   :description_data

  private
    attr_writer :description_data
end
