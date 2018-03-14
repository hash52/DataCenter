class CreateDashboards < ActiveRecord::Migration[5.1]
  def change
    create_table :dashboards do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
