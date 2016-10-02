class CodesController < ApplicationController

  def index
  end

  def description
  end

  def submit_code
    @code_description = CodeDescription.new code: params[:diagnosis_code]
    @code_description.fetch_code_description_data!

    @code_description_presenter = CodeDescriptionPresenter.new @code_description

    respond_to do |format|
      format.js
    end
  end
end
