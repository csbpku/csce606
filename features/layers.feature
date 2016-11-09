@javascript
Feature: Show Markers after selecting Academic Buildings in layers

Background:
	Given I am at the "HomePage"
	When I click on "Layers"
	Then I should see the Popup that contains "Layers"

@javascript
Scenario:
	When I select "Academic Buildings"
	And  I click on "Show Layers" with Buildings
    Then I expect JSON building response

@javascript	
Scenario:
	When I select "Parking Lots"
	And  I click on "Show Layers" with Parking
    Then I expect JSON parking response