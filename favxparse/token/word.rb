module Favxparse
  module Token
    class Word < Base
      MATCH = /\w+(['’]\w+)*/
    end
  end
end
