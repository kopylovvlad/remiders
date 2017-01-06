class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_not_found
    if request.xhr?
      render json: { status: :not_found } and return
    else
      render template: 'errors/404', formats: [:html], status: :not_found and return
    end
  end

  def render_error
    if request.xhr?
      render json: { status: :internal_server_error }, status: :internal_server_error and return
    else
      render template: 'errors/500', formats: [:html], status: :internal_server_error and return
    end
  end
end
