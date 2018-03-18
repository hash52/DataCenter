class StoreCsvJob < ApplicationJob
  require 'csv'
  queue_as :default

  def perform(datafile_id)

    datafile = Datafile.find_by(id: datafile_id)
    datum = datafile.datum

    url = "./public" + datafile.datafile.url
    csv_text = File.read(url)
    csv = CSV.parse(csv_text, headers: true)

    # Register csv data to database
    csv.each_with_index do |row, idx|
      # Create hash from headers and row
      row.each do |key, value|
        datum.create(index: idx, key: key, value: value)
      end
    end
  end
end
