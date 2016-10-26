Feature: Signup Functionality Check
 A click on Signup Button should refresh the page for now.
 
 
Scenario: Checking Signup Option Existence
Given I am at the Trip Planning Signup Page
When I click on the signup button
Then the signup page should be refreshed.