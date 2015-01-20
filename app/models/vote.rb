class Vote < ActiveRecord::Base
  
  scope :up,   -> { where(vote: true) }
  scope :down, -> { where(vote: false) }
  
  scope :reverse_id, -> { order('id DESC') }
  
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voteable, polymorphic: true
  
  validates  :creator, uniqueness:  { scope: [:voteable_type, :voteable_id] }
  
end