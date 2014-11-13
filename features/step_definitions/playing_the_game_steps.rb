def in_browser(name)
  old_session = Capybara.session_name
  Capybara.session_name = name
  yield
  Capybara.session_name = old_session
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
  select('5', :from => 'row')
  select('A', :from => 'column')
  click_button('Fire!')
end

Then(/^I should see whether I have hit a ship or missed$/) do
  pending # express the regexp above with the code you wish you had
end