class Service
	
	def self.schedule
		(1..5).each do |c|
			delay_for(c.minute).tweet("delayed tweet #{c}")
		end
	end

	def self.tweet txt
		client = Twitter::REST::Client.new do |config|
  			config.consumer_key        = "VujifCn7ZGZv5bKmdp78KqmSM"
 			config.consumer_secret     = "LEK8A3l5kw4gZbIU5nhL9DJtI6jg6u3ldHR2kfdt93ACKUDKW1"
  			config.access_token        = "146482713-rH5z8S5Yt7cTjLQalrjh5VzVbo18akh52KSrwdyf"
  			config.access_token_secret = "PS2VJpGQLyjkvuQhKWgL73Rs9114vjVYwNcq2WP7QWk"
		end
		time = Time.now.strftime("%A %d %B %Y - %I:%M %p")
		client.update("#{txt} at : #{time}")
	end

end