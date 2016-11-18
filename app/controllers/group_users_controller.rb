class GroupUsersController < ApplicationController
  before_action :authenticate_admin
  before_action :find_group

  def index
    @group_users = @group.group_users
  end

  def create
    @group.group_users.create!(group_user_params)
    redirect_to group_group_users_path(@group)
  end

  def destroy
    @group_user = @group.group_users.find(params[:id])
    @group_user.destroy
    redirect_to group_group_users_path(@group)
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
  end
  def group_user_params
    params.require(:group_user).permit(:user_id)
  end
end
