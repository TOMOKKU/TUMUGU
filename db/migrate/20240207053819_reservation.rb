class Reservation < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation do |t|
      t.integer :reserver_id
      t.integer :reserved_id
      t.datetime :start_time
      t.datetime :end_time
    end
  end
end
