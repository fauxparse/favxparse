module Favxparse
  module Token
    class Url < Base
      MATCH = %r{https?://[\w\./#]+}

      def skip?
        true
      end
    end
  end
end
