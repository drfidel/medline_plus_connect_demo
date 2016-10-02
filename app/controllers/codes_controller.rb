class CodesController < ApplicationController

  def index
  end

  def description
    @code_description = CodeDescription.new
  end

  def submit_code
    @code_description = CodeDescription.new code: params[:diagnosis_code]
    @code_description.fetch_code_description_data!

    respond_to do |format|
      format.js
    end
  end
end
