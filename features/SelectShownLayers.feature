Feature: Select shown layers 
Scenario:
	Given I am at the Trip Planning Homepage
	When I press the "Layers"
	Then I should on the Popup that contains "Layers"
	When I select "Bicycle Racks"
	And I select "Bus Routes"
	And I press "Show Layers"
	Then I should be on the Trip Planning System home page 