

Given(/^I am at the Trip Planning Login Page$/) do
  visit 'http://localhost:3000'
end

When(/^I click on the login button$/) do
  click_on "Login"
  
end

Then(/^the page should be refreshed\.$/) do
  expect(page).to have_content("Login")
end

