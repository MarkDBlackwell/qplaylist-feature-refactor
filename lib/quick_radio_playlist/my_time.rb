# coding: utf-8

module QuickRadioPlaylist
## TODO: From Ruby 2.1.0, we can use Ruby refinements.
##   Use this new feature here, when available.
##
  module MyTime
    extend self

    def hour_minute_meridian_string(time)                              time. strftime '%2H:%M %p'              end

    def hour_minute_meridian_string_now()  hour_minute_meridian_string time_now                                end

    def time_now(                       )                            ::Time.now.localtime.round                end

    def year_month_day(                t)                            ::Time.new t.year, t.month, t.day         end

    def year_month_day_hour_string( time) (year_month_day_hour         time).strftime '%4Y %2m %2d %2H'        end

    def year_month_day_string(      time) (year_month_day              time).strftime '%4Y %2m %2d'            end

    def year_month_day_string_now(      )  year_month_day_string       time_now                                end

    private

    def year_month_day_hour(           t)                            ::Time.new t.year, t.month, t.day, t.hour end

    def year_month_day_now(             )  year_month_day              time_now                                end
  end
end
