Feature: Using the mass lings-property value setting form

  Background:
    Given I am a visitor
    And the group "Syntactic Structures"
    And the group has a maximum depth of 1
    And the following "Syntactic Structures" lings:
    | name        | depth |
    | English     | 0     |
    | French      | 0     |
    | 2HeadGiant  | 1     |
    And the following "Syntactic Structures" properties:
    | property name     | ling name   | prop val    | category | depth |
    | Adjective Noun    | English     | yes         | Grammar  | 0     |
    | Adjective Degree  | English     | yes         | Grammar  | 0     |
    | Adjective Foo     | French      | sometimes   | Grammar  | 0     |
    | Somethingother    | 2HeadGiant  | yes         | LevelTwo | 1     |
    | Somethingelse     | 2HeadGiant  | no          | LevelTwo | 1     |
    And there is no value set for the ling "English" with the property "Adjective Foo"
    And I go to the group Syntactic Structures
    And I follow the "Ling" with depth "0" model link for the group "Syntactic Structures"

  Scenario: Visitor can get to the ling mass setting form
    Then I should see "English"
    When I follow "English"
    Then I should see "Mass assign"
    When I follow "Mass assign"
    Then I should be on the mass assignment page for "English"

  Scenario: The page lists category-divided checkbox lists for LingsProperties and available values
    When I am on the mass assignment page for "English"
    Then I should see "Grammar"
    And I should not see "LevelTwo"
    And I should see "Adjective Noun"
    And I should see "Adjective Degree"
    And I should not see "Somethingother"

  Scenario: Values are listed as checkbox options, prechecked if already set
    When I am on the mass assignment page for "English"
    And the following scenario is pending
    Then I should see a checkbox for yes on Adjective Noun
    And "yes" should be checked on Adjective Noun
    And I should see a checkbox for yes on Adjective Degree
    And "yes" should not be checked for Adjective Degree
    And I should see a checkbox for yes on Adjective Foo
    And "yes" should not be checked for Adjective Degree

  Scenario: Every LingsProperty should include a text box for adding new values
    When I am on the mass assignment page for "English"
    And the following scenario is pending
    Then I should see a text field for Adjective Noun
    Then I should see a text field for Adjective Degree
