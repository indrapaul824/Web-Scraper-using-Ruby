require 'watir'
require 'webdrivers'
require 'nokogiri'
require 'csv'


browser = Watir::Browser.new
browser.goto 'https://blog.eatthismuch.com/latest-articles/'
parsed_page = Nokogiri::HTML(browser.html)

File.open("parsed.txt", "w") { |f| f.write "#{parsed_page}" }

browser.close

puts parsed_page.title

links = parsed_page.css('a')
links.map { |element| element["href"] }

puts links


CSV.open("articles.csv", "a+") do |csv|
    csv << ["title", "link", "meta"]

    article_cards = parsed_page.xpath("//div[contains(@class, 'td_module_10')]")
    article_cards.each do |card|

        title = card.xpath("div[@class='td-module-thumb']/a/@title")
        link = card.xpath("div[@class='td-module-thumb']/a/@href")
        meta = card.xpath("div[@class='item-details']/div[@class='td-excerpt']")

        csv << [title.first.value, link.first.value, meta.first.text.strip]
    end
end