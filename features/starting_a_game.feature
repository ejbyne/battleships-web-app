Feature: Starting Battle-Ships game
  In order to play battleships
  As a player of the game
  I want to start a new game

Scenario: Visiting the homepage
  Given I visit the homepage
  When I click "New Game"
  Then I should see "Enter your name"

Scenario: Registering first player
  Given I enter my name
  When I click "Register"
  And I am greeted
  Then I should be asked to place my ships

Scenario: Placing ships on the board
  Given I have registered
  And I choose a ship placement
  When I click "Place Ship"
  Then I should see an updated board

Scenario: Getting to the waiting page
  Given I have registered
  And I have placed all of my ships
  When I click "Place Ship"
  Then I should see "Waiting for second player..."