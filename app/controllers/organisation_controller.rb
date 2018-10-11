class OrganisationController < ApplicationController
  skip_before_action :authenticate_user!, only: [:first_user, :create_admin]
  skip_before_action :check_for_first_user, only: [:first_user, :create_admin]

  def first_user
    @user = User.new
  end

  def create_admin
    @user = User.new(admin_params)
    @user.role = 'admin'
    @user.confirmed_at = Time.now
    if @user.save!
      sign_in(@user)
      redirect_to setup_organisation_path
    else
      render action: :first_user
    end
  end

  def setup

  end

  private
  def admin_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
