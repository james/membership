class GroupsController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create]

  def index
    @user_groups = current_user.member.groups
    @groups = current_user.viewable_groups_excluding_joined
  end
  def show
    @group = current_user.viewable_groups.find(params[:id])
  end
  def new
    @group = Group.new(filter: params[:filter])
    @group.users << current_user
  end
  def create
    @group = Group.new(group_params)
    if @group.save!
      @group.update_memberships
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def edit
    @group = current_user.viewable_groups.find(params[:id])
  end
  def update
    @group = current_user.viewable_groups.find(params[:id])
    if @group.update_attributes(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  private

  def group_params
    permitted_attrs = [
      :name,
      :description,
      :why_receiving,
      :automatic_update,
      :joinable,
      :leavable,
      group_users_attributes: [
        :user_id,
        :role,
        :can_manage_members,
        :is_public,
        :can_manage_group,
      ],
    ]
    if current_user.admin?
      permitted_attrs << :filter
    end
    params.require(:group).permit(permitted_attrs)
  end
end
