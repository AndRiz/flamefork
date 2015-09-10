# == Schema Information
#
# Table name: relationships
#
#  id              :integer          not null, primary key
#  participant_id  :integer
#  participated_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Participation < ActiveRecord::Base
  attr_accessible :participated_id


  # a participation belongs to a participant (that is represented by the User model)
  belongs_to :participant, class_name: 'User'

  # a relationship belongs to a participated event (that is represented by the Event model)
  belongs_to :participated, class_name: 'Event'

  # both model attributes must be always present...
  validates :participant_id, presence: true
  validates :participated_id, presence: true

end