class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at
      t.integer :person

      t.timestamps
    end
  end
end
