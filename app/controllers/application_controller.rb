class ApplicationController < ActionController::Base
  before_action :check_for_setup
  before_action :authenticate_user!
  before_action :find_organisation
  protect_from_forgery with: :exception

  private
  def authenticate_admin
    unless current_user && current_user.admin?
      render template: 'shared/not_permitted', status: :forbidden and return
    end
  end

  def find_organisation
    if !public_site?
      @organisation = Organisation.find_by_subdomain(Apartment::Tenant.current)
    end
  end

  def check_for_setup
    if !public_site? && User.count == 0 && request.path != setup_organisation_path
      redirect_to setup_organisation_path
    end
  end

  def public_site?
    Apartment::Tenant.current == 'public'
  end
end
