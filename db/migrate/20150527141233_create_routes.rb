class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name
      t.string :location
      t.string :arrival
      t.float :departure_lat
      t.float :departure_lng
      t.float :arrival_lat
      t.float :arrival_lng
      t.string :difficulty
      t.float :distance
      t.integer :time
      t.integer :user_id

      t.timestamps
    end

    # index to help us retrieve all the events associated with a given user in reverse order
    add_index :routes, [:user_id, :created_at]
  end
end
