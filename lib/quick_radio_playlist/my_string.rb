# coding: utf-8
require 'quick_radio_playlist/my_enumerable'

module QuickRadioPlaylist
## TODO: From Ruby 2.1.0, we can use Ruby refinements (lexically scoped).
##   I.e., we can say:
##      module StringPatches
##        refine String do
##          def prepend_unless_same(  array,                        prepend)
##            (MyEnumerable.all_same? array) ? self : (self.prepend prepend)
##          end
##        end
##      end
##      module SomeModule
##        using StringPatches
##        extend self
##      end
##   Use this new feature here, when available.
##
  module MyString
    extend self

    def prepend_unless_same(  array,   string,                  prepend)
      (MyEnumerable.all_same? array) ? string : (string.prepend prepend)
    end
  end
end
