Feature: Homepage Login
 Only the registered users should be allowed to login 
 to the transport system.
 
Scenario: Checking Login
Given I am at the Trip Planning Login Page
When I enter correct my Username and Password
Then I should be logged in