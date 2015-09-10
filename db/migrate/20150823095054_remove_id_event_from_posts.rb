class RemoveIdEventFromPosts < ActiveRecord::Migration
  remove_column :posts, :id_event
end
