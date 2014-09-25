class Homework < ActiveRecord::Base
	has_many :exercises, dependent: :destroy
	belongs_to :course

	validates :name, presence: true
	validates :course_id, presence: true
end
