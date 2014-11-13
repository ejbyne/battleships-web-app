Given(/^I visit the homepage$/) do
  visit '/'
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

Given(/^I enter my name$/) do
  visit '/'
  step('I click "New Game"')
  fill_in 'player_name', :with => 'Rambo'
end

When(/^I click "(.*?)"$/) do |arg1|
 click_button(arg1)
end

When(/^I am greeted$/) do
  expect(page).to have_content("Hello, Rambo")
end

Then(/^I should be asked to place my ships$/) do
  expect(page).to have_content "Please enter the first coordinates and orientations of your ships"
end

Given(/^I have registered$/) do
  visit '/reset'
  visit '/'
  step('I click "New Game"')
  step('I click "Register"')
end

When(/^I choose a ship placement$/) do
  select('Aircraft Carrier', :from => 'ship')
  select('5', :from => 'row')
  select('A', :from => 'column')
  select('vertical', :from => 'orientation')
end

Then(/^I should see an updated board$/) do
  expect(page).to have_content "Place your next ship..."
end

Given(/^I have placed all of my ships$/) do
  step('I have registered')
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