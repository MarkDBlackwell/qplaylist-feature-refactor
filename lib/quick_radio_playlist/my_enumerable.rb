# coding: utf-8

module QuickRadioPlaylist
## TODO: From Ruby 2.1.0, we can use Ruby refinements.
##   Use this new feature here, when available.
##
  module MyEnumerable
    extend self

    def all_same?(enumerable) 1 >= enumerable.group_by{|e| e}.length end
  end
end
