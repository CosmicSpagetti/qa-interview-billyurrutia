Given("I am on the homepage") do
    find('h2', :text => "Name Generator")
    find('h1', :text => "Find the Perfect Fantasy Name")
end

Then("I will see an Input field for name count") do 
  find_field('count')
end 

Given("I see a default value in the input field") do 
  find_field('count', with: '20')
end 

When(/^I enter a specified number of names (\d+)$/) do |number|
    fill_in('count', with: number)
    find_field('count', with: number)
    unless find_field('count').value == number.to_s
      raise "Count input box empty"
    end
end

And("I click the submit button") do 
  find('.create_form_submit').click
  unless has_content?("Best Suggestions")
    raise "Submit Failed"
  end
  # stupid ads intercept this sometimes 
end 

Then(/^I see the correct number (\d+) of suggestions$/) do |number|
  names_count = page.all('.name').count
  if names_count > 100 
    raise "Maximum is 100 names"
  elsif names_count < number 
    raise "Sorry, we couldn't find #{number} names matching your criteria"
  end
end

Given("All categories are unselected") do 
  click_on("Uncheck all")
  # this check below is super duper slow uncheck it to burn your computer.

  # unless page.all('.fantasy_checkbox_div').any? {|div| div.has_checked_field?}
  #   raise "field left checked"
  # end
end

And(/^I select a single category "(.*?)"$/) do |category|
  check('fantasy_types[]', {option: category.capitalize})
  unless find('.fantasy_checkbox_div', {text: category.capitalize}).has_checked_field?
    raise "#{category} was not checked"
  end
end

Then(/^I see the selected category "(.*?)" is present in each entry of the list of names$/) do |category|
  if page.all('.name').empty? 
    raise "No names present"
  else
    page.all('.name').all? {|x| x.text.include?(category.downcase)}
  end 
end

Given('I click on suggest and see a human name has been added to the input field') do 
  click_on("Suggest")
  if find('.sizeMedium').value == ""
    raise "Suggest input box empty"
  end
end

Then('I see the suggested name in atleast one of the names') do 
  sentence_with_suggested_name = find('h1', :text => "Random Fantasy Names for").text
  sentence_with_suggested_name.slice!("Random Fantasy Names for")
  suggest_name_array = sentence_with_suggested_name.split(" ")
  if suggest_name_array.empty? 
    raise "No name suggested"
  end
  # ummm I can explain 
  unless page.all('.name').any? {|div| suggest_name_array.any? {|name| div.text.downcase.include?(name.downcase)}}
    raise "Suggested name does not exist in any Random Fantasy Names"
  end
end