Given(/^I am at the Trip Planning Signup Page$/) do
  visit 'http://localhost:3000'
end

When(/^I click on the signup button$/) do
  click_on "Sign Up"
  
end

Then(/^the signup page should be refreshed\.$/) do
  expect(page).to have_content("Sign Up")
end