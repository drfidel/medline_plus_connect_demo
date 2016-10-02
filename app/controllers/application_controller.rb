class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from DiagnosisCodeServiceError, with: :display_service_error

  protected

    def display_service_error(exception)
      # TODO: render JS template that displays service error message.
      flash[:error] = exception.message
      redirect_back fallback_location: codes_path
    end
end
