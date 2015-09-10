# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  category        :string
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :category

  # this method realizes the authentication system, basically
  has_secure_password

  # each user can have some posts associated and they must be destroyed together with the user
  has_many :posts, dependent: :destroy

  # each user can have some mails associated and they must be destroyed together with the user
  has_many :mails, dependent: :destroy


  # each user can have some comments associated and they must be destroyed together with the user
  has_many :comments, dependent: :destroy

  # each user can have some events associated and they must be destroyed together with the user
  has_many :events, dependent: :destroy

################################### FOLLOWERS
#
#
  # each user can have many relationships
  # we need to explicitly define a foreign key since, otherwise, Rails looks for a relationship_id column (that not exists)
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy

  # each user can have many followed users, through the relationships table
  # since followed_users does not exist, we need to give to Rails the right column name in the relationships column (with source: "followed_id")
  has_many :followed_users, through: :relationships, source: :followed


  # each user can have many "reverse" relationships (by reading in the opposite way the Relationship model)
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy

  # each user can have many followers, through reverse relationships
  has_many :followers, through: :reverse_relationships

################################### MAIL
#
#

# each user can have many relationships
# we need to explicitly define a foreign key since, otherwise, Rails looks for a relationship_id column (that not exists)
  has_many :mails, foreign_key: 'receiver_id', dependent: :destroy

  # each user can have many followed users, through the relationships table
  # since followed_users does not exist, we need to give to Rails the right column name in the relationships column (with source: "followed_id")
  has_many :receiver_users, through: :mails, source: :receiver


  # each user can have many "reverse" relationships (by reading in the opposite way the Relationship model)
  has_many :reverse_mails, foreign_key: 'receiver_id', class_name: 'Mail', dependent: :destroy

  # each user can have many sensers, through reverse mails
  has_many :senders, through: :reverse_mails

################################### EVENT
#
#
  # each user can have many participations
  # we need to explicitly define a foreign key since, otherwise, Rails looks for a participation_id column (that not exists)
  has_many :participations, foreign_key: 'participant_id'

  # each event can have many participants, through the participations table
  # since participated_events does not exist, we need to give to Rails the right column name in the relationships column (with source: "participated_id")
  has_many :participated_events, through: :participations, source: :participated


########################################################

  # put the email in downcase before saving the user
  before_save { |user| user.email = email.downcase }

  # call the create_remember_token private method before saving the user
  before_save :create_remember_token

  # name must be always present and with a maximum length of 50 chars
  validates :name, presence: true, length: { maximum: 50 }

  # email allowed format representation (expressed as a regex)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d\-]+\.)*polito.it\z/i

  # email must be always present, unique and with a specific format
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # password must have a minimum length of 8 chars
  # password and password_confirmation presence is enforced by has_secure_password
  validates :password, length: { minimum: 8 }









  ###################### FOLLOWERS

  # is the current user following the given user?
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end


  # follow a given user
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  # unfollow a given user
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end






  ################### MAIL

  # SEND A mail to a given user
  def send!(other_user, current_user, mex)
   mails.create!(receiver_id: other_user.id, sender_id:current_user.id, sender_name:current_user.name, message: mex)

  end


  # get the mail to be shown in the wall
 # def feedmail
  #  Mail.from_received(self)
  #end


######################### EVENT PARTICIPATION

  # is the current user participating the given event?
  def participating?(given_event)
    participations.find_by_participated_id(given_event.id)
  end

  # participate a given event
  def participate!(given_event)
    participations.create!(participated_id: given_event.id)
  end

  # unparticipate a given event
  def unparticipate!(given_event)
    participations.find_by_participated_id(given_event.id).destroy
  end

  def maxcheck?(given_event)

    Participation.count(:all, :conditions => "participated_id= #{given_event.id}")!=given_event.max

  end





  ########################### POST


  # get the posts to be shown in the wall
  def feed
    Post.from_users_followed_by(self)
  end

###################################################################################

  # private methods
  private

  def create_remember_token
    # create a random string, safe for use in URIs and cookies, for the user remember token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
