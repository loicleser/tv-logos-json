#!/usr/bin/env ruby
require 'json'

project_name = "aelptos/tv-logos"
json_project_name = "aelptos/tv-logos-json"

puts "> Downloading archive..."
system("curl -L -o archive.zip https://github.com/#{project_name}/archive/refs/heads/main.zip")

puts "> Extracting archive..."
system("unzip archive.zip -x \"*.md\"")
system("mv ./tv-logos-main/countries ./icons")
system("rm -Rf ./tv-logos-main")

puts "> Generating list of icons..."
icons_list = []
Dir.glob("icons/**/*.png").map { |path|
  cleaned = path.delete_prefix!("icons/")
  icons_list << "https://raw.githubusercontent.com/#{project_name}/main/countries/#{cleaned}"
}

puts "> Writing to file..."
json_output = icons_list.to_json
File.write('./icons.json', json_output)

puts "> Cleaning up..."
system("rm -Rf ./icons")
system("rm -Rf ./archive.zip")

puts ">> After pushing to GitHub, you can access the new JSON at https://raw.githubusercontent.com/#{json_project_name}/main/icons.json"
