class Homework < ActiveRecord::Base
	has_many :exercises, dependent: :destroy
	has_one :report
	belongs_to :course

	validates :name, presence: true
	validates :course_id, presence: true

	scope :active, -> { where status: 'true' }
	scope :active_with_course, -> (id) { where("status = true and course_id = ?",id)}
	scope :needing_report, -> { where("need_report = true") }
end
