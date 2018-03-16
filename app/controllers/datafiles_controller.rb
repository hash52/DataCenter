class DatafilesController < ApplicationController
  layout "dashboard"

  def index
    @datafile = Datafile.new
  end

  def create 
    current_user ||= User.find_by(id: session[:user_id])
    if current_user.datafile.create(datafile_params)
      tmp = Datafile.find_by(name: datafile_params['name'])
      name = tmp.name
      url = tmp.datafile.url

      url = "./public"+url
      name_sym = name.to_sym

      csv_text = File.read(url)
      csv = CSV.parse(csv_text, headers: true)

       # Create new database dynamically
      connection = ActiveRecord::Base.connection
      connection.create_table name_sym do |t|
        csv.headers.each do |col|
          t.string col.to_sym
        end
      end

      # Define model based on created database
      klass = Class.new(ActiveRecord::Base) do |c|
        c.table_name = name
      end
      Object.const_defined?(name, klass)

      # Register csv data to database
      csv.each do |row|
      # Create hash from headers and row
      attributes = row.to_hash.slice(*csv.headers)

      # Resister data to db
      klass.create!(attributes)
    end
#      StoreCsvJob.perform_later(tmp.name, tmp.datafile.url)

    else
    end
  end

  private
  def datafile_params
    params.require(:datafile).permit(:name, :datafile)
  end
end
