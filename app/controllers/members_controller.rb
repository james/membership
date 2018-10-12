class MembersController < ApplicationController
  def index
    @filterrific = initialize_filterrific(
      current_user.viewable_members,
      params[:filterrific]
    ) or return
    @members = @filterrific.find

    respond_to do |format|
      format.html do
        @members = @members.page(params[:page]).per(10)
      end
      format.json do
        render json: @members.to_json
      end
    end
  end

  def show
    @member = current_user.viewable_members.find(params[:id])
  end

  def edit
    @member = current_user.member
  end

  def update
    @member = current_user.member
    if @member.update_attributes(member_params)
      redirect_to '/'
    else
      render action: :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(
      :first_name,
      :last_name,
      :phone,
      :mobile,
      :employer,
      :occupation,
      :born_at,
      :address1,
      :address2,
      :city,
      :country_code,
      :post_code,
      :mobile,
    )
  end
end
