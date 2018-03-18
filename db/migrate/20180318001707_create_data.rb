class CreateData < ActiveRecord::Migration[5.1]
  def change
    create_table :data do |t|
      t.integer :datafile_id
      t.integer :index
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
