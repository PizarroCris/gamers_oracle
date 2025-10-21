class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home_redirect, :home]
  def home_redirect
    if user_signed_in?
      redirect_to landing_path
    else
      redirect_to home_path
    end
  end

  def home
    if user_signed_in?
      redirect_to landing_path
    end
  end

  def landing
    unless user_signed_in?
      redirect_to home_path
      return
    end

    @games = Game.all
  end
end