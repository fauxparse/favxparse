module Favxparse
  module Token
    class Base
      attr_reader :text

      def initialize(text)
        @text = text
        @space_before = false
      end

      def space_before=(value)
        @space_before = !!value
      end

      def space_before?
        @space_before
      end

      def open?
        false
      end

      def ==(other)
        to_s == other.to_s
      end

      alias :to_s :text

      delegate :length, to: :text

      def self.match(text, index)
        match = const_get(:MATCH).match(text, index)
        if match && match.offset(0)[0] == index
          new(match[0])
        else
          nil
        end
      end

      def skip?
        false
      end

      def space?
        false
      end
    end
  end
end
