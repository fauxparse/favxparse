module Favxparse
  module Token
    class Url < Base
      MATCH = %r{https?://[[:alpha:]\d\-_\./#]+}i

      def skip?
        true
      end
    end
  end
end
