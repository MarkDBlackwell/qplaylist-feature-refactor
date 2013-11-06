# coding: utf-8
require 'cgi'
require 'xmlsimple'

module QuickRadioPlaylist
  NON_XML_KEYS = %w[ current_time ]
      XML_KEYS = %w[ artist title ]

  KEYS = NON_XML_KEYS + XML_KEYS

  module Run
    extend self

    def compare_recent(currently_playing)
      remembered, artist_title, same = nil, nil, nil # Define in scope.
      File.open 'var/current_song.txt', 'r+' do |f_current_song|
        remembered = f_current_song.readlines.map(&:chomp)
        artist_title = currently_playing.drop 1
        same = remembered == artist_title
        unless same
          f_current_song.rewind
          f_current_song.truncate 0
          artist_title.each{|e| f_current_song.print "#{e}\n"}
        end
      end
      same ? 'same' : nil
    end

    def create_output(substitutions, input_template_file='var/template_sample.html', output_file='var/output.html')
      File.open input_template_file, 'r' do |f_template|
        lines = f_template.readlines
        File.open output_file, 'w' do |f_out|
          lines.each{|e| f_out.print substitutions.run e}
        end
      end
    end

    def last_five_songs_get(times, artists, titles)
      songs_to_keep = 5
      song_count = titles.length
      songs_to_drop = song_count <= songs_to_keep ? 0 : song_count - songs_to_keep
      [ (times.  drop songs_to_drop),
        (artists.drop songs_to_drop),
        (titles. drop songs_to_drop) ].transpose.reverse.
          fill(['','',''], song_count...songs_to_keep).flatten
    end

    def recent_songs_get(currently_playing)
# 'r+' is "Read-write, starts at beginning of file", per:
# http://www.ruby-doc.org/core-2.0.0/IO.html#method-c-new

      n = Time.now
      year_month_day = Time.new(n.year, n.month, n.day).strftime '%4Y %2m %2d'

      times, artists, titles = nil, nil, nil # Define in scope.
      File.open 'var/recent_songs.txt', 'r+' do |f_recent_songs|
        times, artists, titles = recent_songs_read f_recent_songs
# Push current song:
        times.  push currently_playing.at 0
        artists.push currently_playing.at 1
        titles. push currently_playing.at 2
        f_recent_songs.puts year_month_day
        currently_playing.each{|e| f_recent_songs.print "#{e}\n"}
      end
      [times, artists, titles]
    end

    def recent_songs_read(f_recent_songs)
      times, artists, titles = [], [], []
      lines_per_song = 4
      a = f_recent_songs.readlines.map(&:chomp)
      song_count = a.length.div lines_per_song
      (0...song_count).each do |i|
# For now, ignore date, which is at:
#                         i * lines_per_song + 0
        times.  push a.at i * lines_per_song + 1
        artists.push a.at i * lines_per_song + 2
        titles. push a.at i * lines_per_song + 3
      end
      [times, artists, titles]
    end

    def run
      song_currently_playing = Snapshot.new.values
      now_playing = SubstitutionsNowPlaying.new song_currently_playing
      create_output now_playing

      unless 'same' == (compare_recent song_currently_playing)
        times, artists, titles = recent_songs_get song_currently_playing
        five_songs = last_five_songs_get times, artists, titles
#print 'five_songs='; p five_songs
        five = SubstitutionsLatestFive.new five_songs
#print 'five='; p five
        create_output five, 'var/latest_five_template.html', 'var/latest_five.html'
      end
    end
  end

  class Snapshot
    attr_reader :values

    def initialize
      non_xml_values_get
      xml_values_get unless defined? @@xml_values
      @values = @@non_xml_values + @@xml_values
    end

    protected

    def non_xml_values_get
      @@non_xml_values = NON_XML_KEYS.map do |k|
        case k
        when 'current_time'
          Time.now.localtime.round.strftime '%-l:%M %p'
        else
          "(Error: key '#{k}' unknown)"
        end
      end
    end

    def xml_tree
# See http://xml-simple.rubyforge.org/
      result = XmlSimple.xml_in 'var/input.xml', { KeyAttr: 'name' }
#     puts result
#     print result.to_yaml
      result
    end

    def xml_values_get
      relevant_hash = xml_tree['Events'].first['SS32Event'].first
      @@xml_values = XML_KEYS.map{|k| relevant_hash[k].first.strip}
    end
  end

  class Substitutions
    def initialize(fields, current_values)
      @substitutions = fields.zip current_values
    end

    def run(s)
      @substitutions.each do |input,output|
#print '[input,output]='; p [input,output]
        safe_output = CGI.escape_html output
        s = s.gsub input, safe_output
      end
      s
    end
  end

  class SubstitutionsLatestFive < Substitutions
    def initialize(current_values)
      key_types = %w[ time artist title ]
      count = 5
      fields = (1..count).map(&:to_s).product(key_types).map{|digit,key| "[#{key}#{digit} here]"}
#print 'fields='; p fields
      super fields, current_values
    end
  end

  class SubstitutionsNowPlaying < Substitutions
    def initialize(current_values)
      fields = KEYS.map{|e| "[#{e} here]"}
      super fields, current_values
    end
  end
end
