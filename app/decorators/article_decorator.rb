class ArticleDecorator < Draper::Decorator
  delegate_all

  def page_number
    42
  end

  def fetch_domain
  	require 'uri'
  	uri = URI.parse(object)
  	return "#{uri.scheme}://#{uri.host}"
  end

end
