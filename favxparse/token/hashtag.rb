module Favxparse
  module Token
    class Hashtag < Base
      MATCH = /#[[:alpha:]\d_]+/
    end
  end
end
