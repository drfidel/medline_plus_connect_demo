# Handles humanizing of CodeDescription description data.
class CodeDescriptionPresenter

  # @param code_description CodeDescription
  def initialize(code_description)
    @code_description = code_description
  end

  def code
    @code_description.code
  end

  # Returns an array of hashes containing description entries, a relevant
  #  title, and NLM-provided link. Returns array with a default hash with
  #  error message if no description entries found.
  def descriptions
    return [] << empty_data if @code_description.description_data.blank?
    @code_description.description_data
  end

  private
    attr_reader :code_description

    def empty_data
      { title: nil, link: nil, description: 'No descriptions were found for this code.' }
    end
end
