Given(/^I am at the Trip Planning Home page$/) do
  visit 'http://localhost:3000'
end

When(/^I search for Logo$/) do
  find('.navbar-brand').click
end

Then(/^I should get the existence of logo button$/) do
   expect(page).to have_css('.navbar-brand')
end