class DashboardController < ApplicationController
  layout "dashboard"

  def index 
    # new dashboard
    @dashboard = Dashboard.new

    # dashboards which user has 
    current_user ||= User.find_by(id: session[:user_id])
    @dashboards = current_user.dashboard.all
  end

  def show
    @plot = Plot.new
    current_user = User.find_by(id: session[:user_id])
    @datafiles = current_user.datafile
  end

  def create
    current_user ||= User.find_by(id: session[:user_id])
    if current_user.dashboard.create(dashboard_params)
      redirect_to dashboard_index_path
    else
      flash.now[:danger] = "ダッシュボード名が重複しています"
      redirect_to dashboard_index_path
    end
  end

  private
  def dashboard_params
    params.require(:dashboard).permit(:name)
  end
end
