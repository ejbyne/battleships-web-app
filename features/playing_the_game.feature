Feature: Game play
  In order to win the game
  As an active player
  I want to destroy the opponent's fleet

Scenario: Taking the first turn
  Given I visit the game page
  When I fire at the opponent's board
  Then I should see whether I have hit a ship or missed

Scenario: Winning
  Given I have sunk all of my opponent's ships
  Then I should see that I have won the game
  And the other player should see that they have lost
