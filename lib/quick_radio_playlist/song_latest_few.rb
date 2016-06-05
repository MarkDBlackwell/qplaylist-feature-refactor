# coding: utf-8
require 'quick_radio_playlist/data_access'
require 'quick_radio_playlist/song'
require 'quick_radio_playlist/substitutions_latest_few'

module QuickRadioPlaylist
  module SongLatestFew
    extend self

    def cardinality() 5 end

    def output(                           songs)
      (SubstitutionsLatestFew.new acquire songs).
          substitute (filepath 'mustache'),
                     (filepath     'html')
    end

    private

    def acquire(     songs)
#puts 'songs='; pp songs
      padded_songs = songs.reverse +
            ::Array.new(cardinality){Song.new_blank}
      padded_songs.take cardinality
    end

    def filepath(extension) DataAccess.filepath 'latest_five', extension end
  end
end
