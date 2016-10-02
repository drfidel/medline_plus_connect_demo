# TODO DOCUMENT
class CodeDescription
  include ActiveModel::Model
  include DiagnosisCodeHelper
  
  attr_accessor :code, :description_data
end
