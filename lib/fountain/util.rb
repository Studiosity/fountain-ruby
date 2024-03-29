# frozen_string_literal: true

module Fountain
  #
  # Fountain generic utility functions
  #
  module Util
    module_function

    #
    # Stringify symbolized hash keys
    # @param [Hash] hash A string/symbol keyed hash
    # @return Stringified hash
    #
    def stringify_hash_keys(hash)
      new_hash = {}
      hash.each do |key, value|
        new_hash[key.to_s] =
          if value.is_a? Hash
            stringify_hash_keys value
          else
            value
          end
      end
      new_hash
    end

    #
    # Slice keys from hash
    # @param [Hash] hash A hash to slice key/value pairs from
    # @param [Array] *keys The keys to be sliced
    # @return Hash filtered by keys
    #
    def slice_hash(hash, *keys)
      return {} if keys.empty?

      new_hash = {}
      hash.each do |key, value|
        new_hash[key] = value if keys.include? key
      end
      new_hash
    end
  end
end
