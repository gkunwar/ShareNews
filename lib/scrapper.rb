require 'open-uri'

class Scrapper
	attr_accessor :url, :number_of_content, :css_selector, :results
	def initialize(url, css_selector = "div.news_loop", title_selector="", url_selector="", number_of_content = 25)
		@url = url
		@number_of_content = number_of_content
		@css_selector = css_selector
		@title_selector = title_selector
		@url_selector = url_selector
		@results = nil
	end

	def scrape
		page = Nokogiri::HTML(open(@url))
		post_contents = page.css(@css_selector)
		prepare_results post_contents
	end

	private
	def format_result r
		result = ResultFormatter.new(r, @title_selector, @url_selector)
		result.format!
		result.formatted_result	
	end

	def prepare_results(raw_response)
		@results = Array.new
		raw_response.take(@number_of_content).each {|r|
			@results << format_result(r)
		}	
	end

end

