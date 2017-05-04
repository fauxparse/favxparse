module Favxparse
  module Token
    class Username < Base
      MATCH = /@[[:alpha:]\d_]+/
    end
  end
end
