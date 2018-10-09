class OrganisationController < ApplicationController
  skip_before_action :authenticate_user!, only: :setup

  def setup
  end
end
