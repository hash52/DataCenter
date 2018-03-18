class PlotsController < ApplicationController
  layout 'dashboard'

  def index
    current_file = Datafile.find_by(id: session[:datafile_id])
    @plots = current_file.plot.all
  end

  def new

    @plot = Plot.new

    current_file = Datafile.find_by(id: session[:datafile_id])
    current_data = current_file.datum
    @columns = current_data.distinct.pluck(:key)
      
  end

  def show
    current_file = Datafile.find_by(id: session[:datafile_id])
    current_data = current_file.datum
      
    plot_table = current_file.plot
    if plot_table.exists?
      current_plot = plot_table.first
      
      @x_column = current_plot.x_column
      @y_column = current_plot.y_column

      @plot_type = current_plot.plot_type

      @x_data = current_data.select(:value).where(key: @x_column)
      @x_data = @x_data.pluck(:value).map(&:to_i)

      @y_data = current_data.select(:value).where(key: @y_column)
      @y_data = @y_data.pluck(:value).map(&:to_i)
    end
  end

  def create
    datafile ||= Datafile.find_by(id: session[:datafile_id])
    if datafile.plot.create(plot_params)
      redirect_to plots_path
    else
      redirect_to new_plot_path
    end
  end

  private
  def plot_params
    params.require(:plot).permit(:title, :plot_type, :x_column, :y_column)
  end
end
