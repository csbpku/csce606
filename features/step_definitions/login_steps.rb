

Given(/^I am at the Trip Planning Homepage$/) do
  visit 'http://localhost:3000'
end

When(/^I search for Login Button$/) do
  
end

Then(/^I should get  the existence of login button$/) do
  expect(page).to have_content("Login")
end