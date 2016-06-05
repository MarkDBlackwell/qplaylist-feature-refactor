# coding: utf-8

module QuickRadioPlaylist
## TODO: From Ruby 2.1.0, we can use Ruby refinements.
##   Use this new feature here, when available.
##
  module MyArray
    extend self

    def lengths(a) a.map(&:length) end

    def only(a) raise 'Should be just one.' unless 1 == a.length; a.first end

    def terminate(a) a.flatten.map{|e| "#{e}\n"} end

    def terminate_join(a) (terminate a).join '' end
  end
end
