class PeopleController < ApplicationController
  def index
    @filterrific = initialize_filterrific(
      current_user.viewable_people,
      params[:filterrific]
    ) or return
    @people = @filterrific.find

    respond_to do |format|
      format.html do
        @people = @people.page(params[:page]).per(10)
      end
      format.json do
        render json: @people.to_json
      end
    end

  end
  def show
    @person = current_user.viewable_people.find(params[:id])
  end
end
