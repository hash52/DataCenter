class DatafilesController < ApplicationController
  layout "dashboard"

  def index
    @datafile = Datafile.new
  end

  def create 
    current_user ||= User.find_by(id: session[:user_id])
    if current_user.datafile.create(datafile_params)
      tmp = Datafile.find_by(name: datafile_params['name'])
      StoreCsvJob.perform_later(tmp.name, tmp.datafile.url)
    end
  end

  private
  def datafile_params
    params.require(:datafile).permit(:name, :datafile)
  end
end
