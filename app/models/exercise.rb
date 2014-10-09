class Exercise < ActiveRecord::Base

	belongs_to :homework
	mount_uploader :file, FileUploader

	validates :name, presence: true
	validates :file, presence: true
	validates :homework_id, presence: true

	def self.do_search params
		hm = Homework.find(params[:homework_id])
		ex = hm.exercises.find_or_create_by(name: params[:name])
		unless ex.new_record?
			ex.destroy
		end
	end
	
	def search_access(pass) 
    	url = "http://deimos.dgi.uanl.mx/cgi-bin/wspd_cgi.sh/eselcarrera.htm?HTMLUsuCve=#{self.name}&HTMLPassword=#{pass}&HTMLTipCve=01"
   	    doc = Nokogiri::HTML(open(url))
   	    return !doc.css('//form').first.nil?
	end
end
