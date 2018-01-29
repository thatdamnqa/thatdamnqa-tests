require "selenium-webdriver"
require 'test/unit'
require "test/unit/assertions"
include Test::Unit::Assertions

driver = Selenium::WebDriver.for :chrome

# I have two URLs. Check that both work
driver.navigate.to "http://daniel.shaw.works"
assert(driver.find_element(:css, ".site-branding__name-link").text.include?("Daniel Shaw"), "daniel.shaw.works is loading")

driver.navigate.to "http://thatdamnqa.com"
assert(driver.find_element(:css, ".site-branding__name-link").text.include?("Daniel Shaw"), "thatdamnqa.com is loading")

# Check featured portfolio ordering/items
driver.navigate.to "http://daniel.shaw.works/portfolio"

elements = driver.find_elements(:css, ".node__title-link")

header_text_list = elements.map { |element| element.text }

assert(header_text_list == ([
    "The Hitchhiker's Guide to the Galaxy game (30th Anniversary edition)",
    "CBeebies Storytime",
    "Patch:Manchester",
    'joind.in (frontend rewrite)'
]))

driver.navigate.to "http://thatdamnqa.com/speaking"
assert(
    driver.find_element(:css, "#block-clairshaw-content > div > div > div.view-header > p").text.include?(
        "I love to speak at any opportunity, usually about code quality. There are details of some usergroup, conference, and lightning talks I've done below."
    ),
    "Speaking text"
)

