# coding: utf-8
require 'quick_radio_playlist/my_array'
require 'quick_radio_playlist/my_enumerable'
require 'quick_radio_playlist/my_hash'
require 'quick_radio_playlist/my_string'

module QuickRadioPlaylist
  module SongInitialize
    extend self

    def set_from_clock(           hash)
      default      = '00:00'
      key_from     = :clock
      ordered_keys = %i[ hour minute ]
      prepend      = '0'
      separator    = ':'
      key_split prepend, default, hash, ordered_keys, separator, key_from
      hash
    end

    def set_from_date(            hash)
      default      = '0000 00 00'
      key_from     = :date
      ordered_keys = %i[ year month day ]
      prepend      = '20'
      separator    = ' '
      key_split prepend, default, hash, ordered_keys, separator, key_from
      hash
    end

    def set_from_time(            hash)
      default      = '00:00 AM'
      key_from     = :time
      ordered_keys = %i[ clock meridian ]
      prepend      = '0'
      separator    = ' '
      key_split prepend, default, hash, ordered_keys, separator, key_from
      hash
    end

    private

## TODO: From Ruby 2.1, we can say:
##      def new_way(foo:) foo end
##   Use this new feature here, when available.
##
    def key_split(             prepend, default, hash, ordered_keys, separator, key_from)
      raise 'Empty parameter.' if
                              [prepend, default, hash, ordered_keys, separator, key_from].
          any?{|e| e.empty?}
      string  =                                  hash.fetch                     key_from
#puts           'string='; pp                      string
      string  =                         default if string.empty?
      string_split,                     default_split =
                [string,                default].map{|e| e.split     separator}
      v = values string_split, prepend, default_split
      MyHash.safe_set                            hash, ordered_keys, v
    end

    def values(string_split,       prepend, default_split)
      both =  [string_split,                default_split]
      lengths =                                         MyArray.lengths both
      MyString.                    prepend_unless_same (MyArray.lengths both.map(&:first)),
               string_split.first, prepend
      (MyEnumerable.                          all_same?         lengths) ?
               string_split :               default_split
    end
  end
end
