Feature: Login Functionality Check
 A click on Login Button should refresh the page for now.
 
 
Scenario: Checking Login Option Existence
Given I am at the Trip Planning Login Page
When I click on the login button
Then the page should be refreshed.