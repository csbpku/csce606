
When(/^I press the "Direction"$/) do
  
end

Then(/^I should be on the page with Trip planner popup$/) do
	expect(page).to have_content("Trip planner")
end

And(/^I fill in "From" with "HEB"$/) do

end
	
And(/^I fill in "To" with "Harvy R. Bright Building"$/) do

end

And(/^I press "Find Directions"$/) do

end

Then(/^I should be on the Trip Planning System home page$/) do
	visit 'http://localhost:3000'
end
