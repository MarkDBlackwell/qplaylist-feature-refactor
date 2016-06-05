# coding: utf-8
require 'quick_radio_playlist/my_file'

module QuickRadioPlaylist
  module DataAccess
    extend self

    def append(    filepath,   s) MyFile.append          filepath, s               end

    def filepath(name, extension) ::File.join(*dirname + ["#{name}.#{extension}"]) end

    def read(      filepath     ) MyFile.read            filepath                  end

    def read_array(filepath     ) MyFile.readlines_chomp filepath                  end

    def write(     filepath,   s) MyFile.write           filepath, s               end

    private

# Relative:
    def dirname(                ) %w[ var ]                                        end
  end
end
