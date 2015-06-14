namespace :scrape do
  desc "TODO"
  task :url => :environment do
  	[:onlinekhabar, :ekantipur, :ratopati, :setopati].each do |url|
  		obj = NewsScrapper.new(url)
  		obj.scrape
  		puts "Completed #{url}"
  	end
  end
end