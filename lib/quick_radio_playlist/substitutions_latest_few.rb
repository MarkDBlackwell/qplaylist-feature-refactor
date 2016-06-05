# coding: utf-8
require 'quick_radio_playlist/substitutions'

module QuickRadioPlaylist
  class SubstitutionsLatestFew < Substitutions
    def initialize(latest_few_songs)
#puts             'latest_few_songs='; pp latest_few_songs
      values =     latest_few_songs.map{|e| e.values_at(*keys)}.flatten
#puts 'values='; pp                           values
#puts             'key_table='; pp key_table
      super ::Hash[key_table.zip              values]
    end

    private

    def key_table() ((1.upto SongLatestFew.cardinality).to_a.product keys).map{|digit,key| "#{key}#{digit}"} end

    def keys() %i[ artist start_time title ] end
  end
end
