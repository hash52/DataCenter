class CreateDatafiles < ActiveRecord::Migration[5.1]
  def change
    create_table :datafiles do |t|
      t.integer :user_id
      t.string :name
      t.boolean :reading, default: true
      t.string :datafile

      t.timestamps
    end
  end
end
