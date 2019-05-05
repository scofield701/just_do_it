class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:nickname, :intro, :sex, :image]
    devise_parameter_sanitizer.permit :account_update, keys: [:nickname, :intro, :sex, :image]
  end

  def after_sign_in_path_for(resource)
    users_path
  end

  def set_search
    @search = User.ransack(params[:q]) #ransackメソッド推奨
    @search_items = @search.result(distinct: true).page(params[:page]).per(8).order(id: "DESC")
  end

  def user_sex?(user)
    if user.sex == "男"
      return 1
    else
      return 0
    end
  end
end
