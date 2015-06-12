class Article < ActiveRecord::Base
  paginates_per 20
  include Votable
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :url, url: true # Provided by "validate_url" gem

  before_create :fetch_image_url

  private
  def fetch_image_url
  	obj = ImageGrabber.new(url)
  	self.image_url = obj.go_grab
  end
end
