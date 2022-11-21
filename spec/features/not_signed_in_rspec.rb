require 'rails_helper'

RSpec.feature "Projects without being signed in", type: :feature do
    context "Create new project" do
    before(:each) do
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    scenario "should fail" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit edit_project_path(project)
    end

    scenario "should fail" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      visit project_path(project)
      click_button "Destroy this project"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
      end
    end
end