class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  private
  def authenticate_admin
    unless current_user && current_user.admin?
      render template: 'shared/not_permitted', status: :forbidden and return
    end
  end
end
