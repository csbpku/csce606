Given(/^I am on the Home page$/) do
  visit root_path
end

When(/^I click Directions$/) do
  click_on "Direction"
end

Then(/^I should see Directions Dialog Box$/) do
  expect(page).to have_content("Trip planner")
end
