class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def confirmation_needed

  end
end
