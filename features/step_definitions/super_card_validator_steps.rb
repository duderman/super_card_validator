When(/^I get help for "([^"]*)"$/) do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

When(/^I get help for command "([^"]*) ([^"]*)"$/) do |app_name, action_name|
  @app_name = app_name
  step %(I run `#{app_name} help #{action_name}`)
end

When(/^I validate number(s|) "([\d\s]+)" with command "([^"]*)"/) do |_, numbers, command|
  step %(I run `#{command} #{numbers}`)
end
