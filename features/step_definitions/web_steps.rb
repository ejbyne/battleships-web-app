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
end

When(/^I click "(.*?)"$/) do |arg1|
 click_button(arg1)
end


Then(/^I should be asked to place my ships$/) do
  visit '/place_ships'
end

# Given(/^I enter my name$/) do
#   visit '/'
#   fill_in 'player_name', :with => 'Rich'
# end

# Given(/^I click submit$/) do
#   click_button('Submit')
# end

# Then(/^I should see a welcome message$/) do
#   expect(page).to have_content("Hello, Rich") 
# end