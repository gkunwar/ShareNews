require 'rubygems'
require 'nokogiri'
require 'open-uri'

## This class is userd to grab the image from the url for link post
class ImageGrabber
  DEFAULT_IMAGE= nil
  ALLOWED_EXTENSIONS=['jpeg','jpg','png']


  attr_accessor :image_path

  ## Constructor for the class ImageGrabber
  # Parse the url and set to the image path as nil
  def initialize(url)
    @url = URI.parse(url)
    @image_path = nil
  end

  ## Grab the image path from the url
  # Returns the image path
  def go_grab
    begin
      site = open(@url)
    rescue
      @image_path= default_image
    end
    page = Nokogiri::HTML(site)
    images = page.css('body img')
    if images.present?
      source = String.new
      images.each do |i|
        source = i['src']
        break if source.present?
      end
      if source.present?
        @image_path= full_image_path(source)
      else
        @image_path= default_image
      end
    else
      @image_path= check_if_image ? @url.to_s : default_image
    end
  end

private

  ## Checks if the given url directly is an image
  def check_if_image
    tmp_array = @url.to_s.split('.')
    if tmp_array.count > 1
      extension = tmp_array.last
      if ALLOWED_EXTENSIONS.include?(extension)
        return true
      end
    end
    return false
  end
  ## Returns the full  path of the image including host name
  def full_image_path(source)
    begin
     encoded_source = URI.encode(source)
     if !URI.parse(encoded_source).host.present?
      path = "http://" + @url.host + "/" + source
      else
        path = source
      end
    rescue Exception => e
      path = default_image
    end
  end

  ## Returns the default image path
  def default_image
    DEFAULT_IMAGE
  end
end