require "rails_helper"

RSpec.feature "Visiting the homepage", type: :feature do
  context "Create new project" do
    before(:each) do
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
        fill_in "Description", with: "Test description"
      end
    end

    scenario "should go back to homepage" do
      click_link "Back to projects"
      expect(page).to have_content("Projects")
    end
  end
end