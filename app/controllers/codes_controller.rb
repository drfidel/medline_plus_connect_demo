class CodesController < ApplicationController

  rescue_from DiagnosisCodeServiceError, with: :display_service_error

  def index
  end

  def description
    @code_description = CodeDescription.new
  end

  def submit_code
    @code_description = CodeDescription.new code: params[:diagnosis_code]
    @code_description.fetch_code_description!

    respond_to do |format|
      format.js
    end
  end

  protected

    def display_service_error(exception)
      # TODO: render JS template that displays service error message.
      flash[:error] = exception.message
      redirect_back fallback_location: codes_path
    end
end
