Given(/^I visit the homepage$/) do
  visit '/'
end

When(/^I click on "(.*?)"$/) do |arg1|
  click_button(arg1)
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

Given(/^I enter my name$/) do
  visit '/'
  step('I click on "New Game"')
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

