class DatafilesController < ApplicationController
  layout "dashboard"

  def index
    # For new datafile
    @datafile = Datafile.new

    # For listing datafiles
    current_user = User.find_by(id: session[:user_id])
    @datafiles = current_user.datafile.all
  end

  def create 
    current_user ||= User.find_by(id: session[:user_id])
    current_file ||= current_user.datafile.create(datafile_params)
    if current_file
      datafile_id = current_file.id
      StoreCsvJob.perform_later(datafile_id)
     
      session[:datafile_id] = current_file.id
      redirect_to datafiles_path
    else
      flash.now[:danger] = "データの登録に失敗しました"
      render :index
      redirect_to datafiles_path
    end
  end

  def destroy
    Datafile.find_by(id: params[:id]).destroy
    Datum.where(datafile_id: params[:id]).destroy_all
    redirect_to datafiles_path
  end

  private
  def datafile_params
    params.require(:datafile).permit(:name, :datafile)
  end
end
