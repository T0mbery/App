class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to companies_path
    end
  end
end
