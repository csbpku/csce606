Given(/^I am at the Trip Planning Login Page$/) do
  
end

When(/^I enter correct my Username and Password$/) do
   visit 'http://localhost:3000'
end

Then(/^I should be logged in$/) do
  expect(page).to have_content("Login")
end