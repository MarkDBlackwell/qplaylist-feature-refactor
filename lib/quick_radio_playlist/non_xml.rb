# coding: utf-8
require 'quick_radio_playlist/my_time'

module QuickRadioPlaylist
  module NonXml
    extend self

    def to_h
      values =      keys.map do |key|
        case                     key
        when :current_time then time_reformatted MyTime.hour_minute_meridian_string_now
        else raise "Key '#{      key}' unknown."
        end
      end
      ::Hash[       keys.zip values]
    end

    private

    def keys() %i[ current_time ] end

    def time_reformatted(s) (s.start_with? '0') ? (s.slice 1..-1) : s end
  end
end
