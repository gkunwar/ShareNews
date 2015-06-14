require 'open-uri'

class ResultFormatter
	attr_accessor :title, :post_type, :text, :url

	def initialize(content, title_selector = "h2 a", url_selector = "h2 a", text_selector = "div.thing div.entry div.expando div.md p")
		@content = content
		@title_selector = title_selector
		@url_selector = url_selector
		@text_selector = text_selector
	end

	def format!
		@url = extract_url
		@title = extract_title
	end

	def formatted_result
		{url: @url, title: @title}
	end

	private
	def extract_title
		@content.css(@title_selector)[0].text unless @content.css(@url_selector)[0].nil?
	end

	def extract_url
		@content.css(@url_selector)[0]['href'] unless @content.css(@url_selector)[0].nil?
	end

end
