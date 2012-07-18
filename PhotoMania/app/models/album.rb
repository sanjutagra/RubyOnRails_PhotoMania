class Album < ActiveRecord::Base
  attr_accessible :aname
	belongs_to :user
	has_many :photos
end
