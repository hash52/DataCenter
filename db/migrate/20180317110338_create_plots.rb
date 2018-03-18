class CreatePlots < ActiveRecord::Migration[5.1]
  def change
    create_table :plots do |t|
      t.integer :datafile_id
      t.string :title
      t.string :plot_type
      t.string :x_column
      t.string :y_column

      t.timestamps
    end
  end
end
