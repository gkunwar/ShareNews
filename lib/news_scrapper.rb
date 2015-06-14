class NewsScrapper
	URL_LIST = {onlinekhabar: {:url => "http://www.onlinekhabar.com/category/news/", content_div: "div.news_loop", title_selector: "h2 a", url_selector: "h2 a"}, 
							ekantipur: {:url => "http://www.ekantipur.com/np/samachar/", content_div: "div.newsList li", title_selector: "h6.blue-bold a", url_selector: "h6.blue-bold  a"},
							ratopati: {url: "http://www.ratopati.com/category/politics", content_div: "article.index-container", title_selector: "h1.index-title a", url_selector: "h1.index-title a"},
							setopati: {url: "http://setopati.com/", content_div: "div.samachar.item ul.news_list li", title_selector: "a", url_selector: "a"}}
	MODEL_NAME = :article


	attr_accessor :url_type, :url, :results, :content_div, :title_selector, :url_selector

	def initialize(type)
		@url_type = type
		site = URL_LIST[type]
		@url = site[:url]
		@content_div = site[:content_div]
		@title_selector = site[:title_selector]
		@url_selector = site[:url_selector]
	end

	def scrape
		scraper = Scrapper.new(@url, @content_div, @title_selector , @url_selector ,25)
		scraper.scrape
		@results = scraper.results.reverse
		data_handler = DataHandler.new(@url_type)
		data_handler.store(@results, MODEL_NAME)
	end

end