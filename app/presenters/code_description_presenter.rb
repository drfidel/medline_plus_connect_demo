# Handles humanizing of CodeDescription description data.
class CodeDescriptionPresenter

  # @param code_description CodeDescription
  def initialize(code_description)
    @code_description = code_description
  end

  def code
    @code_description.code
  end

  def descriptions
    @description_hash ||= [].tap do |ary|
      @code_description.description_data.each do |description|
        ary << {
          title:       description[:title][:_value],
          link:        description[:link].first[:href],
          description: description[:summary][:_value]
        }
      end.empty? and begin
        ary << empty_data
      end
    end
  end

  private
    attr_reader :code_description

    def empty_data
      { title: nil, link: nil, description: 'No descriptions were found for this code.' }
    end
end
