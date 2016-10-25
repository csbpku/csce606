Feature: Navigate to an on-campus building as a visitor
Scenario:
	Given I am at the Trip Planning Homepage
	When I press the "Direction" 
	And I fill in "From" with "HEB"
	And I fill in "To" with "Harvy R. Bright Building"
	And I press "Find Directions"
	Then I should be on the Trip Planning System home page 