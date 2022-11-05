require "rails_helper"

RSpec.feature "Visiting the homepage", type: :feature do
  scenario "The visitor should see projects" do
    visit root_path
    expect(page).to have_text("Projects")
  end

  scenario "User logged in should see a new project option" do
    visit root_path
    expect(page).to have_text("New project")
  end

  context "Editing project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "Edit project" do
      visit project_path(project)
      click_link "Edit this project"
      expect(page).to have_content("Editing project")
      end
    end
  end

  context "Update the project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "Edit project" do
      visit project_path(project)
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
      end
    end
  end

  context "Show the project" do
    let!(:project) { Project.create(title: "Test title", description: "Test content") }
    scenario "Edit project" do
      visit root_path
      click_link "Show this project"
      expect(page).to have_content(project.title)
      expect(page).to have_content(project.description)
      end
    end
  end
end

