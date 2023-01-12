require 'rails_helper'

RSpec.feature "Sign up", type: :feature do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }

  before do
    visit new_user_registration_path
  end

  scenario "with valid data" do
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "confirmation", with: password
    click_button "Sign up"

    expect(page).to have_content("")
  end

  scenario "invalid when email already exists" do
    @user = create :user

    fill_in "Email", with: @user.email
    fill_in "Password", with: password
    fill_in "confirmation", with: password
    click_button "Sign up"

    expect(page).to have_no_text "Welcome! You have signed up successfully."
    expect(page).to have_text "Email has already been taken"
  end

  scenario "invalid when email is empty" do
    fill_in "Email", with: ""
    fill_in "Password", with: password
    fill_in "confirmation", with: password
    click_button "Sign up"

    expect(page).to have_no_text "Welcome! You have signed up successfully."
    expect(page).to have_text "Email can't be blank"
  end

  scenario "invalid when password is empty" do
    fill_in "Email", with: email
    fill_in "Password", with: ""
    fill_in "confirmation", with: ""
    click_button "Sign up"

    expect(page).to have_no_text "Welcome! You have signed up successfully."
    expect(page).to have_text "Password can't be blank"
  end
end
