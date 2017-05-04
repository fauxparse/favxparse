module Favxparse
  module Token
    class Space < Base
      MATCH = /[ ]+/

      def initialize(text = ' ')
        super(text)
      end

      def skip?
        true
      end

      def space?
        true
      end
    end
  end
end
