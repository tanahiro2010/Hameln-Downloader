# frozen_string_literal: true
require 'selenium-webdriver'


print("Input book_id $")
book_id = gets.chomp
driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://syosetu.org/novel/#{book_id}/1.html"


title = driver.find_element(:xpath, '//*[@id="maind"]/div[1]/p[1]/span/a').text
text = ""
no = 1
while true
  text += "\n\n\-- Episode #{no} --\n\n"
  text += driver.find_element(:id, "honbun").text
  nextPageLink = driver.find_elements(:class, 'next_page_link')

  if nextPageLink.length == 0
    break
  end
  nextPageLink[0].click
  no += 1
end

File.open(file="#{title}.txt", mode="w") do |file|
  file.write(text)
end