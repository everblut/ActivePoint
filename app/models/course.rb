class Course < ActiveRecord::Base
	has_many :homeworks, dependent: :destroy
	belongs_to :teacher

	validates :name, presence: true
	validates :teacher_id, presence: true
end
