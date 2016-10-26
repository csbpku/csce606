Given(/^I am at the Trip Planning home Page$/) do
  visit 'http://localhost:3000'
end

When(/^I click on the logo$/) do
  find('.navbar-brand').click
end

Then(/^I reach the home page.$/) do
  expect(current_path) == ('http://localhost:3000')
end