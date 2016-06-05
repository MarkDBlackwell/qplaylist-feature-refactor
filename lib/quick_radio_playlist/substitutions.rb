# coding: utf-8
require 'mustache'
require 'quick_radio_playlist/data_access'

module QuickRadioPlaylist
  class Substitutions
    def initialize(     hash)
      raise 'Expected a Hash.' unless
                        hash.is_a?  ::Hash
      @substitutions =  hash
#puts '@substitutions='; pp  @substitutions
    end

    def substitute(f_in, f_out)
#puts 'f_out='; pp       f_out
      mustache = ::Mustache.new
      mustache.template = DataAccess.read f_in
#(puts '@substitutions='; pp @substitutions) if @substitutions.is_a? ::Hash
      @substitutions.each_pair do |input,   output|
#puts '[input, output]='; pp      [input,   output]
        \
                   mustache[       input] = output
      end
      s =          mustache.render
#puts 's='; pp s
      DataAccess.write   f_out, s
    end
  end
end
