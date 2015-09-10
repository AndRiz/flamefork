class AddTimeMaxToEvents < ActiveRecord::Migration
  def change
    add_column :events, :max, :integer
  end
end
