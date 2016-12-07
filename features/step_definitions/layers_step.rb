Given(/^I am at the "HomePage"$/) do
    visit root_path
end

When(/^I click on "Layers"$/) do
  click_on "Layer"
end

Then(/^I should see the Popup that contains "Layers"$/) do
	expect(page).to have_content("Layers")
end

When(/^I select "Academic Buildings"$/) do
    find("#Building").set true
end

When(/^I select "Parking Lots"$/) do
    find("#Parking").set true
end

And(/^I click on "Show Layers" with Buildings$/) do
    click_on "Layers"
    get "/dropPins?layer%5Bbuilding%5D=1"
end

And(/^I click on "Show Layers" with Parking$/) do
    click_on "Layers"
    get "/dropPins?layer%5Bparking%5D=1"
end

Then(/^I expect JSON building response$/) do
  data = JSON(last_response.body)
  expect(data["layer"][0]["objtype"]).to eq("Building")
end

Then(/^I expect JSON parking response$/) do
  data = JSON(last_response.body)
  expect(data["layer"][0]["objtype"]).to eq("Parking")
end