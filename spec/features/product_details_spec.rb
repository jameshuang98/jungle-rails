require 'rails_helper'
require 'images'

RSpec.feature "Visitor navigates from home page to the product detail page", type: :feature, js: true do

  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click on a product and see all product details" do
    # ACT
    visit root_path
    find("article.product a.btn", match: :first).click
    sleep 3

    # DEBUG
    # save_screenshot

    # VERIFY
    expect(page).to have_css '.product-detail'
  end


end