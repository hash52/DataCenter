class Api::DatafilesController < ApplicationController
  def index
    @reading_id = Datafile.where("user_id = ? and reading = ?", session[:user_id], false).pluck(:id)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
