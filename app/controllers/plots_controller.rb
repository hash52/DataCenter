class PlotsController < ApplicationController
  def create
    datafile = Datafile.find_by(id: session[:datafile_id])
    if datafile.plot.create(plot_params)
      redierct_to controller: 'datafiles', action: 'show',
        id: session[:datafile_id]
    else
      flush.now[:danger] = "グラフを作成できません"
      redirect_to controller: 'datafiles', action: 'show',
        id: session[:datafile_id]
    end
  end

  private
  def plot_params
    params.require(:plot).permit(:title, :type, :x_data, :y_data)
  end
end
