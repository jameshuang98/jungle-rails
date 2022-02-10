require 'rails_helper'
require 'images'

RSpec.feature "User logs in and are taken to the home page where they can see their name", type: :feature, js: true do

  #SETUP
  before :each do
    @user = User.create!(
      first_name: 'John',
      last_name: 'Doe',
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end


  scenario "They click 'Add to Cart' and see cart increase by one" do
    # ACT
    visit login_path
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'password'
    click_button 'Submit'

    
    # DEBUG
    # sleep 3
    # save_screenshot

    # VERIFY
    expect(page).to have_content('John')
  end


end
