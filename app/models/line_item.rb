class LineItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :product # connects the line_item to that specific product; this allows the line_item to access product information as well

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

end
