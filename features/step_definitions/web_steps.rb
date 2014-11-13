def in_browser(name)
  old_session = Capybara.session_name
  Capybara.session_name = name
  yield
  Capybara.session_name = old_session
end

# def swap_sessions
#   Capybara.current_driver = Capybara.current_driver == :selenium ? :rack_test : :selenium
# end

Given(/^I visit the homepage$/) do
  in_browser(:one) do
    visit '/reset'
    visit '/'
  end
end

Then(/^I should see "(.*?)"$/) do |arg1|
  in_browser(:one) do
    expect(page).to have_content(arg1)
  end
end

Given(/^I enter my name$/) do
  in_browser(:one) do
    visit '/'
    step('I click "New Game"')
    fill_in 'player_name', :with => 'Rambo'
  end
end

When(/^I click "(.*?)"$/) do |arg1|
  in_browser(:one) do
    click_button(arg1)
  end
end

When(/^I am greeted$/) do
  in_browser(:one) do
    expect(page).to have_content("Hello, Rambo")
  end
end

Then(/^I should be asked to place my ships$/) do
  in_browser(:one) do
    expect(page).to have_content "Please enter the first coordinates and orientations of your ships"
  end
end

Given(/^I have registered$/) do
  in_browser(:one) do
    visit '/reset'
    visit '/'
    step('I click "New Game"')
    step('I click "Register"')
  end
end

When(/^I choose a ship placement$/) do
  in_browser(:one) do
    select('Aircraft Carrier', :from => 'ship')
    select('5', :from => 'row')
    select('A', :from => 'column')
    select('vertical', :from => 'orientation')
  end
end

Then(/^I should see an updated board$/) do
  in_browser(:one) do
    expect(page).to have_content "Place your next ship..."
  end
end

Given(/^I have placed all of my ships$/) do
  in_browser(:one) do
    step('I have registered')
    select('Aircraft Carrier', :from => 'ship')
    select('5', :from => 'row')
    select('A', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
    select('Destroyer', :from => 'ship')
    select('5', :from => 'row')
    select('B', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
    select('Submarine', :from => 'ship')
    select('5', :from => 'row')
    select('C', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
    select('Battleship', :from => 'ship')
    select('5', :from => 'row')
    select('D', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
    select('Patrol Boat', :from => 'ship')
    select('5', :from => 'row')
    select('E', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
  end
end

Given(/^another person has visited the homepage$/) do
  in_browser(:two) do
    visit '/'
  end
end

When(/^another person has clicked "(.*?)"$/) do |arg1|
  in_browser(:two) do
    click_button(arg1)
  end
end

When(/^another person has entered their name$/) do
  in_browser(:two) do
    fill_in 'player_name', :with => 'Sarah'
  end
end

When(/^that person has placed all of his ships$/) do
  in_browser(:two) do
    select('Aircraft Carrier', :from => 'ship')
    select('5', :from => 'row')
    select('A', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
    select('Destroyer', :from => 'ship')
    select('5', :from => 'row')
    select('B', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
    select('Submarine', :from => 'ship')
    select('5', :from => 'row')
    select('C', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
    select('Battleship', :from => 'ship')
    select('5', :from => 'row')
    select('D', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
    select('Patrol Boat', :from => 'ship')
    select('5', :from => 'row')
    select('E', :from => 'column')
    select('vertical', :from => 'orientation')
    click_button('Place Ship')
  end
end

Then(/^that person should see "(.*?)"$/) do |arg1|
  in_browser(:two) do
    expect(page).to have_content(arg1)
  end
end

  # swap_sessions
  # in_browser(:two) do
  #   visit '/'
  #   step('I click "New Game"')
  #   fill_in 'player_name', :with => 'Sarah'
  #   step('I click "Register"')

  # end
# end

