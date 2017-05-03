require 'digest/sha1'

module Favxparse
  module Twitter
    class Digest
      attr_reader :text

      def initialize(text)
        @text = text
      end

      def digest
        @digest ||= ::Digest::SHA1.hexdigest(stripped)
      end

      alias :to_s :digest

      private

      def stripped
        Tokeniser.new(text).tokens.join.gsub(/[^\w]+/, '').downcase
      end
    end
  end
end
