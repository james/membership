class GroupMembershipsController < ApplicationController
  before_action :find_group

  def create
    @group.group_memberships.create!(member: current_user.member)
    flash[:notice] = "You are now a member of #{@group.name}"
    redirect_to group_path(@group)
  end

  def destroy
    @group_membership = @group.group_memberships.where(member: current_user.member).first
    @group_membership.destroy
    flash[:notice] = "You have left #{@group.name}"
    redirect_to group_path(@group)
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
  end
end
