class GroupMembershipsController < ApplicationController
  before_action :find_group
  before_action :authenticate_admin, only: [:index]

  def index
    @memberships = @group.group_memberships
    @addable_members = Member.all - @group.members
  end

  def create
    if current_user.admin?
      @group.group_memberships.create!(group_member_params)
      redirect_to group_group_memberships_path(@group)
    else
      @group.group_memberships.create!(member: current_user.member)
      flash[:notice] = "You are now a member of #{@group.name}"
      redirect_to group_path(@group)
    end
  end

  def destroy
    if current_user.admin?
      @group_membership = @group.group_memberships.find(params[:id])
      @group_membership.destroy
      redirect_to group_group_memberships_path(@group)
    else
      @group_membership = @group.group_memberships.where(member: current_user.member).first
      @group_membership.destroy
      flash[:notice] = "You have left #{@group.name}"
      redirect_to group_path(@group)
    end
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
  end

  def group_member_params
    params.require(:group_membership).permit(:member_id)
  end
end
