require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end

  context "Create new project" do
    before(:each) do
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Submit"
      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail" do
      click_button "Submit"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Create Project Without Title" do
    let(:project) { Project.create(title:"", description:"Test Description") }
    before(:each) do
      visit new_project_path
      within("form") do
        fill_in "Description", with: "Test Description"
      end
    end

    scenario "should fail" do
      click_button "Submit"
      expect(page).to have_content("Title can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit edit_project_path(project)
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Submit"
      expect(page).to have_content("Project was successfully updated")
    end

    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Submit"
      expect(page).to have_content("Description can't be blank")
    end

    scenario "should also fail" do
      within("form") do
        fill_in "Title", with: ""
      end
      click_button "Submit"
      expect(page).to have_content ("Title can't be blank")
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "remove project" do
      visit project_path(project)
      click_button "Destroy this project"
      expect(page).to have_content("")
      expect(Project.count).to eq(0)
      end
    end
end