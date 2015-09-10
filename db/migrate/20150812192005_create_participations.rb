class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :participated_id
      t.integer :participant_id

      t.timestamps
    end
  end
end
