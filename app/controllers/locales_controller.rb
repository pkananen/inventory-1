class LocalesController < ApplicationController 
  def index
    if current_user # if I'm logged in
      current_user.locale = params[:locale] # change my locality
      current_user.save
    end        
    session[:locale] = params[:locale]               
    redirect_to :back
    end
  end
