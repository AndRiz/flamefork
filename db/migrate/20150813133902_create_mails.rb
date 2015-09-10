class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :title
      t.string :message

      t.timestamps
    end
  end
end
