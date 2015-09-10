class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end

    # index to help us retrieve all the posts associated with a given user in reverse order
    add_index :comments, [:user_id, :created_at]
  end
end
