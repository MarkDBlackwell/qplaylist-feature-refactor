# coding: utf-8
require 'quick_radio_playlist/hour_current'
require 'quick_radio_playlist/song_latest_few'
require 'quick_radio_playlist/song_now_playing'
require 'quick_radio_playlist/song_recent'
require 'quick_radio_playlist/song_recent_database'

module QuickRadioPlaylist
  module SongChangeHandle
    extend self

    def run(               song)
      song_add             song
      history_update
      return if hour_same? song
      require 'quick_radio_playlist/hour_change_handle'
      HourChangeHandle.run
    end

    private

    def history_update
      songs = SongRecentDatabase.songs
#puts 'songs.last='; pp          songs.last
      SongLatestFew.output       songs
      SongRecent.   output       songs
    end

    def hour_same?(song) HourCurrent.same? song end

    def song_add(               song)
      SongNowPlaying.txt_update song
      SongRecentDatabase.merge  song
    end
  end
end
