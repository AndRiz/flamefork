# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  receiver_id  :integer
#  sender_id    :integer
#  title        :string
#  message      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null

class Mail < ActiveRecord::Base
  attr_accessible :message, :receiver_id, :sender_name, :sender_id

  # a mail belongs to a sender (that is represented by the User model)
  belongs_to :sender, class_name: 'User'

  # a relationship belongs to a followed user (that is represented by the User model)
  belongs_to :receiver, class_name: 'User'


  # descending order for getting the mails
  default_scope order: 'mails.created_at DESC'

  # sender_id be present while creating a new mail...
  validates :sender_id, presence: true

  # receiver_id must be present while creating a new mail...
  validates :receiver_id, presence: true

  # message must be present and not longer than 500 chars
  validates :message, presence: true, length: {maximum: 500}

  # get user's received mails
  ##def self.from_received(user)
    #received_mails_ids = 'SELECT receiver_id FROM mails WHERE sender_id= :user_id'

   # where("user_id IN (#{received_mails_ids}) OR user_id = :user_id", user_id: user.id)
  #end


end