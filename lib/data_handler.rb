class DataHandler

	attr_accessor :type
	def initialize(type)
		@type = type
	end

	def store(results, klass=:post)
		begin
			klass = klass.to_s.camelize.constantize
		rescue
			return
		end
		user = bot_user
		results.each do |r|
			r[:user_id] = user.id
			post = klass.create(r)
		end
	end


	private

	def bot_user
		email = "bot_#{@type.to_s}@gmail.com"
		user = User.find_by_email(email)
		user == nil ? create_user : user
	end

	def create_user
		user = User.create(:email => "bot_#{@type.to_s}@gmail.com", :password => "password", :password_confirmation => "password")
	end


end