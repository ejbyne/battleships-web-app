def in_browser(name)
  old_session = Capybara.session_name
  Capybara.session_name = name
  yield
  Capybara.session_name = old_session
end

def sink_all_opponents_ships_but_one_cell
  Capybara.app::GAME.opponent.board.grid.each do |key, value|
    unless key == :B5
      value.content.hit! if value.content.is_a?(Ship)
    end
  end
end

Given(/^I visit the game page$/) do
  in_browser(:one) do
    visit '/reset'
    visit '/'
    step('I click "New Game"')
    step('I click "Register"')
    step('I have placed all of my ships')
  end
  in_browser(:two) do
    visit '/'
    step('another person has clicked "New Game"')
    step('another person has clicked "Register"')
    step('that person has placed all of his ships')
  end
end

When(/^I fire at the opponent's board$/) do
  in_browser(:one) do
    visit '/waiting'
    select('5', :from => 'row')
    select('A', :from => 'column')
    click_button('Fire!')
  end
end

Then(/^I should see whether I have hit a ship or missed$/) do
  in_browser(:one) do
    expect(page).to have_content('You have hit a ship!')
  end
end

Given(/^I have taken my first turn$/) do
  in_browser(:one) do
    step("I visit the game page")
    step("I fire at the opponent's board")
  end
end

When(/^the other player takes his turn$/) do
  in_browser(:two) do
    visit '/game'
    select('5', :from => 'row')
    select('A', :from => 'column')
    click_button('Fire!')
  end
end

Then(/^the other player should see whether he has hit a ship or missed$/) do
  in_browser(:two) do
    expect(page).to have_content('You have hit a ship!')
  end
end

Given(/^I have sunk all of my opponent's ships$/) do
  in_browser(:one) do
    step("I visit the game page")
    sink_all_opponents_ships_but_one_cell
    visit '/game'
    select('5', :from => 'row')
    select('B', :from => 'column')
    click_button('Fire!')
  end
end

Then(/^I should see that I have won the game$/) do
  in_browser(:one) do
    expect(page).to have_content('You have won!')
  end
end

Then(/^the other player should see that they have lost$/) do
  in_browser(:two) do
    visit '/game'
    expect(page).to have_content('You have lost!')
  end
end
