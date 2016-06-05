# coding: utf-8
require 'quick_radio_playlist/my_enumerable'
require 'quick_radio_playlist/my_hash'
require 'quick_radio_playlist/my_time'
require 'quick_radio_playlist/song_initialize'

module QuickRadioPlaylist
  class Song
    attr_reader :to_h

    def self.keys_for_blank_song()
      %i[ artist clock current_time date day hour meridian minute month start_time time title year ]
    end

    def self.   new_blank
      song = new ::Hash[keys_for_blank_song.product ['']]
#puts 'song='; pp                      song
      MyHash.verify_blank              song
    end

    def initialize(                 hash)
      h = MyHash.convert_to_symbols hash
#puts                                  'h='; pp h
      time =                     MyTime.time_now
      MyHash.safe_set h, :date, (MyTime.      year_month_day_string    time)
#puts '(h.fetch :date)='; pp (h.fetch :date)
      MyHash.safe_set h, :time, (MyTime.hour_minute_meridian_string    time)
#puts '(h.fetch :time)='; pp (h.fetch :time)
      MyHash.store_all_same             h, %i[ current_time start_time time ]
      \
          SongInitialize.set_from_clock \
          SongInitialize.set_from_time  \
          SongInitialize.set_from_date  h
#puts                                  'h='; pp h
      @to_h = check_length              h
    end

    def fetch(key) @to_h.fetch key end

    def store(key, value) @to_h.store key, value end

    def values() @to_h.values end

    def values_at(*keys) @to_h.values_at(*keys) end

    private

    def check_length(                                hash)
      desired = self.class.keys_for_blank_song
      unless MyEnumerable.all_same? [       desired, hash].map(&:length)
        message = "When "       "creating song #{pp  hash
              }, number of keys should be #{desired.             length}."
        raise message
      end
      hash
    end
  end
end
