# coding: utf-8

module QuickRadioPlaylist
## TODO: From Ruby 2.1.0, we can use Ruby refinements.
##   Use this new feature here, when available.
##
  module MyFile
    extend self

    def append(         filepath,       s)   write_mode      filepath, 'ab', s              end

    def read(           filepath         ) ::File.open(      filepath, 'rb') {|f| f.read  } end

    def readlines_chomp(filepath         )  (read            filepath).split "\n"           end

    def write(          filepath,       s)   write_mode      filepath, 'wb', s              end

    private

    def readlines(      filepath         )  MyArray.terminate readlines_chomp filepath      end

    def write_mode(     filepath, mode, s) ::File.open(      filepath, mode){|f| f.write s} end
  end
end
