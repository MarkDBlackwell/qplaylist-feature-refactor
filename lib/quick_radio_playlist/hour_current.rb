# coding: utf-8
require 'quick_radio_playlist/data_access'
require 'quick_radio_playlist/my_array'
require 'quick_radio_playlist/my_enumerable'
require 'quick_radio_playlist/my_time'

module QuickRadioPlaylist
  module HourCurrent
    extend self

    def read() (DataAccess.read_array filepath).push('').first.chomp end

    def same?(song) MyEnumerable.all_same? [(start_hour song), read] end

    def start_hour(           song)
      "#{start_year_month_day song} #{
         start_hour_only      song}"
    end

    def txt_update() write MyTime.year_month_day_hour_string MyTime.time_now end

    private

    def filepath() DataAccess.filepath 'current_hour', 'txt' end

    def start_hour_only(song)
      default = '00'
      hour    =       ((song.fetch :time).split ':').fetch 1, default # Using Array#fetch.
#puts 'hour='; pp hour
      (hour.prepend default).slice (-default.length..-1)
    end

    def start_year_month_day(song)
      default = '0000 00 00'
      string  =              song.fetch :date
      both = [string, default].map{|e| e.split ' '}.map(&:length)
#puts 'both='; pp both
      (MyEnumerable.all_same? both) ? string : default
    end

    def write(                    string)
      s = MyArray.terminate_join [string]
      DataAccess.write filepath,  s
    end
  end
end
