class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.references :attendee, null: false, foreign_key: { to_table: :users }
      t.references :event, null: false, foreign_key: true
      t.boolean :accepted_by_guest, null: false, default: false
      t.timestamps
    end
  end
end
