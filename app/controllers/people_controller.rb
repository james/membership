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

  def edit
    @person = current_user.person
  end

  def update
    @person = current_user.person
    if @person.update_attributes(person_params)
      redirect_to '/'
    else
      render action: :edit
    end
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :phone)
  end
end
