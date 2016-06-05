# coding: utf-8
require 'quick_radio_playlist/snapshot'
require 'quick_radio_playlist/song'
require 'quick_radio_playlist/song_now_playing'

module QuickRadioPlaylist
  module XmlEventHandle
    extend self

    def run() handle gather end

    private

    def gather() Song.new Snapshot.capture end

    def handle(             song)
#puts 'song='; pp           song
      SongNowPlaying.output song
      return if song_same?  song
      require 'quick_radio_playlist/song_change_handle'
      SongChangeHandle.run  song
    end

    def song_same?(song) SongNowPlaying.same? song end
  end
end
