require 'rails_helper'


describe "the signin process", type: :feature do
  before :each do
    User.create(first_name: 'Alex', last_name: 'Chen', email: 'user@example.com', password: 'password')
  end
  #first create a user 
  it "signs me in and displays email address after sign in at profile page" do
    visit("/login")
    # within("#session") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    # end
    click_button 'Log in'
    expect(page).to have_content 'user@example.com'
  end
end
