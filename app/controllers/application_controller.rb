class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def set_search
      @q = Post.ransack(params[:q])
      @posts = @q.result.find_newest_post(params[:page]).with_user_and_comment
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :description, :new_avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :description, :new_avatar])
  end
end
