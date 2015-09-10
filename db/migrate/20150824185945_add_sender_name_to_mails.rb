class AddSenderNameToMails < ActiveRecord::Migration
  def change
    add_column :mails, :sender_name, :string
  end
end
