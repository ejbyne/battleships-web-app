Feature: Battle-Ships game
  In order to play battleships
  As a player of the game
  I want to play battleships with another player

Scenario: Visiting the homepage
  Given I visit the homepage
  Then I should see "Welcome to Battle Ships!"

Scenario: Register to play game
  Given I enter my name
  And I click submit
  Then I should see a welcome message