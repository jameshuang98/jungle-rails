require 'rails_helper'
require 'images'

RSpec.feature "User clicks 'Add to Cart' for a product on the home page", type: :feature, js: true do

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

  scenario "They click 'Add to Cart' and see cart increase by one" do
    # ACT
    visit root_path
    find("article.product button.btn", match: :first).click
    
    # DEBUG
    # sleep 3
    # save_screenshot

    # VERIFY
    expect(page).to have_content('My Cart (1)')
  end


end
