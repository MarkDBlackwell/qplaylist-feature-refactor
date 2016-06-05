# coding: utf-8
require 'mustache'
require 'quick_radio_playlist/data_access'

module QuickRadioPlaylist
  module SongRecent
    extend self

    def output(   songs)
      mustache  =                       ::Mustache.new
      mustache.template = DataAccess.
          read          filepath         'mustache'
      processed = songs.
          map(&:to_h).map do |each|
        drop_leading_zeros = (each.fetch :hour).to_i.to_s
        \
                              each.merge  hour: drop_leading_zeros
      end
      mustache[  :songs] = processed.reverse
      DataAccess.write (filepath 'html'), mustache.render
    end

    private

    def filepath(extension) DataAccess.filepath 'recent_songs', extension end
  end
end
