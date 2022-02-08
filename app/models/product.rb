class Product < ActiveRecord::Base
  # Using the Money-Rails gem, each Product object will have an attribute called price which is a Money object
  monetize :price_cents, numericality: true
  
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

end
