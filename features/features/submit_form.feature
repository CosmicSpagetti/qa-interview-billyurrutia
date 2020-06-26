Feature: Submit Form

  Background:
    Given   I am on the homepage

  Scenario: Submit the form with a specified number of names
    Then    I will see an Input field for name count 

  Scenario: Input fields start with default value
    Then    I see a default value in the input field

  Scenario: Submit the form with a specified number of names and validate that the correct number of suggestions populates
    When    I enter a specified number of names 10
    And     I click the submit button
    Then    I see the correct number 10 of suggestions 
  
  Scenario: Selecting a single category 
    Given   All categories are unselected 
    And     I select a single category "Angel"
    Then    I click the submit button

  Scenario: Validate that the selected category from scenario 3 is present in each entry of the list of names
    Given   All categories are unselected
    And     I select a single category "Angel"
    And     I click the submit button
    Then    I see the selected category "Angel" is present in each entry of the list of names

  Scenario: Validate that the suggested human name (either first or last name) from Suggest input field is present at least once in the list of names
    Given   I click on suggest and see a human name has been added to the input field 
    And     I click the submit button
    Then    I see the suggested name in atleast one of the names
