# coding: utf-8
require 'quick_radio_playlist/data_access'
require 'quick_radio_playlist/my_array'
require 'quick_radio_playlist/my_enumerable'
require 'quick_radio_playlist/substitutions'

module QuickRadioPlaylist
  module SongNowPlaying
    extend self

    def output(song) (Substitutions.new song.to_h).substitute (filepath 'mustache'), (filepath 'html') end

    def same?(song) MyEnumerable.all_same? [(build_string song), txt_read] end

    def txt_update(song) DataAccess.write (filepath 'txt'), (build_string song) end

    def xml_read() DataAccess.read filepath 'xml' end

    private

    def build_string(song) MyArray.terminate_join song.values_at(*ordered_keys) end

    def filepath(extension) DataAccess.filepath 'now_playing', extension end

    def ordered_keys() %i[ artist title ] end

    def txt_read() DataAccess.read_array filepath 'txt' end
  end
end
