# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  # only content and title must be accessible, in order to avoid manual (and wrong) associations between posts and users
  attr_accessible :content, :title

  # each post belong to a specific user
  belongs_to :user

  # descending order for getting the posts
  default_scope order: 'posts.created_at DESC'

  # user_id must be present while creating a new post...
  validates :user_id, presence: true

  # title must be present and longer than 5 chars
  validates :title, presence: true, length: {minimum: 5}

  # content must be present and not longer than 500 chars
  validates :content, presence: true, length: {maximum: 500}

  # get user's posts and all the posts written by her followed users
  def self.from_users_followed_by(user)
    followed_user_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'

    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

end
