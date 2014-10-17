class Course < ActiveRecord::Base
	has_many :homeworks, dependent: :destroy
	belongs_to :teacher

	validates :name, presence: true
	validates :teacher_id, presence: true

	scope :active, -> { where status: 'true' } 
	scope :active_with_teacher, -> (id) { where("status = true and teacher_id = ?",id)}
end
