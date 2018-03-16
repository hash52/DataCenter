class StoreCsvJob < ApplicationJob
  require 'csv'
  queue_as :default

  def perform(name, url)

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
  end
end
