require "rails_helper"

RSpec.feature "user logs in" do
  before(:each) do
    User.create(email: "Justin@example.com", password: "password")
  end

  let(:user) { User.find_by(email: "Justin@example.com") }

  scenario "with valid credentials" do
    visit root_path
    click_link("Login")

    expect(page).to have_content("Login")
    expect(current_path).to eq(login_path)

    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button("Login")

    expect(page).to have_content("Justin@example.com")
    expect(current_path).to eq("/users/#{user.id}")
  end

  scenario "with invalid credentials" do
    visit root_path
    click_link("Login")
    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "passwor"
    click_button "Login"

    expect(page).to_not have_content("Justin@example.com")
    expect(current_path).to eq(login_path)
  end
end
