require 'dotenv'
require 'google/api_client'
require 'google_drive'
require 'nokogiri'

Dotenv.load

target_path = '~/Desktop/hiteatech.github.io'

# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
session = GoogleDrive.saved_session("config.json")

ws = session.spreadsheet_by_key(ENV['KEY']).worksheets[0]

page = Nokogiri::HTML(open("../hiteatech.github.io/javascript.html"))

# count the number
num_attendee = 0

# Create the first li element if there is no li element
unless page.at_css('.collection-item')
  ul = page.at_css('.collection')
  ul.children = %Q[<li class="collection-item" id="auto-collection-item">#{ws[2, 2]}<span class="badge">#{ws[2, 5]}</span></li>]

  # update attendee count
  num_attendee += 1
end

li = page.css('.collection-item')
max = li.length - 1

unless max == ws.num_rows
  start = max + 2
  (start..ws.num_rows).each do |row|
    li[max].add_next_sibling %Q[<li class="collection-item" id="auto-collection-item">#{ws[row, 2]}<span class="badge">#{ws[row, 5]}</span></li>]

    # refresh li
    li = page.css('.collection-item')
    max += 1

    # update attendee count
    num_attendee += 1
  end
end

# For Checking Purpose
# puts page.to_html

# Overwrite to the file
File.write("../hiteatech.github.io/javascript.html", page.to_html)

# Run command to push to github
puts %x{ cd #{target_path} && git cm -am "Added #{num_attendee} attendee(s)" && git push origin master }

# Yet another way to do so.
# p ws.rows  #==> [["fuga", ""], ["foo", "bar"]]

# Reloads the worksheet to get changes by other clients.
ws.reload
