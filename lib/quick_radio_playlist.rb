# coding: utf-8
=begin
Author: Mark D. Blackwell (google me)
October 9, 2013 - created
October 10, 2013 - Add current time
October 24, 2013 - Escape the HTML
October 31, 2013 - Add latest five songs
November 8, 2013 - Use Mustache format
November 11, 2013 - Generate recent songs in HTML

Description:

See README.md.

lib = File.expand_path '..', __FILE__
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include? lib

# Note: Ruby version 1.9 (and newer) has RubyGems built-in;
#   however, requiring it doesn't hurt.

# require 'rubygems'
=end

require 'bundler/setup'

require 'quick_radio_playlist/run'
require 'quick_radio_playlist/version'

module ::QuickRadioPlaylist
  Run.run
end
