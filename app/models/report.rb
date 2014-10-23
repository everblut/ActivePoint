class Report < ActiveRecord::Base

	belongs_to :homework

	validates :name, presence: true
	validates :homework_id, presence: true

	def short_name
		name.split("/").last
	end
end
