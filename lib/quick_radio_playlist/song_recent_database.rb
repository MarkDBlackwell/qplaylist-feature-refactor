# coding: utf-8
require 'quick_radio_playlist/data_access'
require 'quick_radio_playlist/hour_current'
require 'quick_radio_playlist/my_array'
require 'quick_radio_playlist/song'

module QuickRadioPlaylist
  module SongRecentDatabase
    extend self

    def filter() DataAccess.write filepath, (stringify reduce songs) end

    def merge(song) DataAccess.append filepath, (stringify song) end

    def songs() song_enum.map{|values| Song.new ::Hash[ordered_keys.zip values]} end

    private

    def comparison_time
      y, m, d, h = (HourCurrent.read.split ' ').map(&:to_i)
      two_weeks = 60 * 60 * 24 * 7 * 2
      ::Time.new(y, m, d, h) - two_weeks
    end

    def filepath() DataAccess.filepath 'recent_songs', 'txt' end

    def ordered_keys() %i[ date start_time artist title ] end

    def ordered_values(object)
      if               object.respond_to? :map
        object.map{|e|    ordered_values e}
      else
        object.values_at(*ordered_keys)
      end
    end

    def reduce(         songs)
#puts 'comparison_time='; pp comparison_time
      songs.select  do |song|
#puts       'song='; pp song
        date      =     song.fetch :date
        year, month, day =         (date.split ' ').map(&:to_i)
        song_time =        ::Time.new year, month, day
#puts  'song_time='; pp song_time
        song_time > comparison_time
      end
    end

    def song_enum
      lines_per_song = ordered_keys.length
      lines   = DataAccess.read_array filepath
      length  =          lines.     length
      message = "Bad number '#{     length}'" \
        " of recent song lines; fix #{filepath}."
#puts                   'lines='; pp           lines
      raise message unless 0 ==     length %   lines_per_song
      cardinality =                 length.div lines_per_song
      array       =                 length.times.to_a
      ::Enumerator.
          new(cardinality) do |yielder|
        (array.each_slice                      lines_per_song).map{|indices|
                               yielder.yield   lines.    values_at(*indices)}
      end
    end

    def stringify(object) MyArray.terminate_join ordered_values object end
  end
end
