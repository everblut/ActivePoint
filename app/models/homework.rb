class Homework < ActiveRecord::Base

	has_many :exercises, dependent: :destroy
	has_one :report
	belongs_to :course

	validates :name, presence: true
	validates :course_id, presence: true
	validates :end_date, :presence => true
	before_update :check_date

	scope :active, -> { where status: 'true' }
	scope :active_with_course, -> (id) { where("status = true and course_id = ?",id)}
	scope :needing_report, -> { where("need_report = true") }

	def check_date
		if Time.now > end_date
			update_attribute(:status,false)
		end
	end
end
