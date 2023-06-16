class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.datetime :date
      t.string :name, limit: 255
      t.text :description

      t.timestamps
    end
  end
end
