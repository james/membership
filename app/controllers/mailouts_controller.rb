class MailoutsController < ApplicationController
  before_action :find_group

  def show
    @mailout = @group.mailouts.find(params[:id])
  end

  def new
    @mailout = @group.mailouts.new
  end

  def create
    @mailout = @group.mailouts.new(mailout_params)
    if @mailout.save
      redirect_to group_mailout_path(@group, @mailout)
    else
      render action: :new
    end
  end

  def send_email
    @mailout = @group.mailouts.find(params[:id])
    @mailout.send_email
    redirect_to group_mailout_path(@group, @mailout)
  end

  private
  def find_group
    @group = current_user.viewable_groups.find(params[:group_id])
  end

  def mailout_params
    params.require(:mailout).permit(:subject, :body, :from_email)
  end
end
