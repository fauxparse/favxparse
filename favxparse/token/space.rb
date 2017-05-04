module Favxparse
  module Token
    class Space < Base
      MATCH = /[ ]+/

      def skip?
        true
      end

      def space?
        true
      end
    end
  end
end
