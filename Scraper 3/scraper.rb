require 'watir'
require 'webdrivers'
require 'nokogiri'

browser = Watir::Browser.new

browser.goto 'https://blog.techtalks.com.br/'
parsed_page = Nokogiri::HTML(browser.html)

File.open("parsed.txt", "w") {
    |file| file.write "#{parsed_page}"
}

browser.close