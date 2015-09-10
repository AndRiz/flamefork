class RemoveColumn < ActiveRecord::Migration
  remove_column :events, :participants
end
