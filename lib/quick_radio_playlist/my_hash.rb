# coding: utf-8

module QuickRadioPlaylist
## TODO: From Ruby 2.1.0, we can use Ruby refinements.
##   Use this new feature here, when available.
##
  module MyHash
    extend self

    def convert_to_symbols(hash)
      result =             hash.dup
      keys   =             result.      keys
      keys.each                     do |key|
        next if                         key.respond_to? :to_sym
        sym =                           key.             to_sym
        raise "Cannot convert string '#{key  }' to symbol:" \
                         " hash already has"     " symbol #{sym}." if \
                           result.  has_key?                sym
        result.store sym, (result.fetch key)
        result.delete                   key
      end
      result
    end

    def safe_set(     hash,          keys,                 values)
      return                         keys.             zip(values).each{|k,v| 
          safe_set    hash, k, v} if keys.respond_to? :zip
      safe_set_scalar hash,          keys,                 values
    end

    def store_all_same(hash,         keys)
      indices =                      keys.length.times.to_a
      indices.map{|i| indices.partition{|e| e == i}}.
          each                                        do |single, rest|
        key   =                      keys.at MyArray.only single
        next unless    hash.has_key? key
        value =        hash.fetch    key
        rest.each{|i|  hash.store   (keys.at i), value}
      end
    end

    def verify_blank(hash)
      unless        (hash.values.join '').empty?
        raise  "#{pp hash} should be blank."
      end
      hash
    end

    private

    def safe_set_scalar(hash,         key, value)
      return if         hash.has_key? key
      hash.store                      key, value
    end
  end
end
