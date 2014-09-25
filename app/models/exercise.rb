class Exercise < ActiveRecord::Base
	belongs_to :homework, dependent: :destroy
	mount_uploader :file, FileUploader

	validates :name, presence: true
	validates :file, presence: true
	validates :homework_id, presence: true
end
