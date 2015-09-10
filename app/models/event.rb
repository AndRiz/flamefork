# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  location      :string(255)
#  arrival       :string(255)
#  departure_lat :float
#  departure_lng :float
#  arrival_lat   :float
#  arrival_lng   :float
#  difficulty    :string(255)
#  distance      :float
#  time          :datetime
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  max           :integer
#

class Event < ActiveRecord::Base
  attr_accessible :location, :arrival, :arrival_lat, :arrival_lng, :location_lat, :location_lng, :difficulty, :distance, :name, :time, :max


  # link between addresses and their coordinates
  geocoded_by :location, :latitude => :location_lat, :longitude => :location_lng
  geocoded_by :arrival, :latitude => :arrival_lat, :longitude => :arrival_lng

  # geocode!
  after_validation :geocode_both

  # each event belong to a specific user
  belongs_to :user

  # descending order for getting the events
  default_scope order: 'events.created_at DESC'

  # validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :location, presence: true
  validates :time, presence: true
  validates :max, presence: true,  numericality: { only_integer: true }

  # each event can have many "reverse" participations (by reading in the opposite way the participations model)
  has_many :reverse_participations, foreign_key: 'participated_id', class_name: 'Participation', dependent: :destroy

  # each event can have many participants, through reverse participations
  has_many :participants, through: :reverse_participations

  # each user can have some comments associated and they must be destroyed together with the user
  has_many :comments, dependent: :destroy




  private

  # geocode both the start and arrival addresses
  def geocode_both
    self.location_lat, self.location_lng = Geocoder.coordinates(self.location)
    self.arrival_lat, self.arrival_lng = Geocoder.coordinates(self.arrival)
  end

end
