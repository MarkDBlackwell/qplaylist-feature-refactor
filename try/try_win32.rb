# coding: utf-8
require 'win32/service'

a = ::Win32::Service.services
puts a.length, a.first
print %Q@"\ndisplay_name  current_state  start _type\n\n"@
20.times do |i|
  e = a.at i
  puts %Q@#{e.display_name}   \t\t\t\t#{e.current_state}   \t#{e.start_type}@
end
