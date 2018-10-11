class OrganisationsController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'public_site'

  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(organisation_params)
    if @organisation.save
      redirect_to "http://#{@organisation.subdomain}.lvh.me"
    else
      render action: :new
    end
  end

  private
  def organisation_params
    params.require(:organisation).permit(:name, :subdomain)
  end
end
