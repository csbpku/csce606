Given(/^I am at the Trip Planning homepage$/) do
  visit 'http://localhost:3000'
end

When(/^I search for signup Button$/) do
  
end

Then(/^I should get the existence of signup button$/) do
  expect(page).to have_content("Sign Up")
end