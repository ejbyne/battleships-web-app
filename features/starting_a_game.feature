Feature: Starting Battle-Ships game
  In order to play battleships
  As a player of the game
  I want to start a new game

Scenario: Visiting the homepage
  Given I visit the homepage
  When I click on "New Game"
  Then I should see "Enter your name"
