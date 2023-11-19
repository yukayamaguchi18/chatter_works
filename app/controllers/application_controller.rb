class ApplicationController < ActionController::Base

  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource_or_scope)
    case resource_or_scope
    when Admin
      admin_root_path
    when User
      root_path
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when Admin
      admin_root_path
    when User
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin   # ログアウト時はシンボルが返ってくる
      new_admin_session_path
    when :user  # ログアウト時はシンボルが返ってくる
      new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image, :introduction])
  end

end
