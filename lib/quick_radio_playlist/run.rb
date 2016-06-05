# coding: utf-8

## Stages, or modules, or states:

# WindowsService
# XmlEventHandle
# SongChangeHandle
# HourChangeHandle
# Afterward

module QuickRadioPlaylist
  module Run
    extend self

    def run
      return unless xml_event?
      require 'quick_radio_playlist/xml_event_handle'
      XmlEventHandle.run
    end

    private

    def xml_event?() true end
  end
end
