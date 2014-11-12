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
  visit '/'
  step('I click "New Game"')
  step('I click "Register"')
end

When(/^I choose a ship placement$/) do
  select('A', :from => 'aircraft_carrier_row')
  select('5', :from => 'aircraft_carrier_column')
  select('Vertical', :from => 'aircraft_carrier_orientation')
end

Then(/^I should see an updated board$/) do
  pending # express the regexp above with the code you wish you had
end