class AddIdEventToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :id_event, :integer
  end
end
