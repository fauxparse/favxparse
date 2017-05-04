module Favxparse
  module Token
    class Closing < Base
      MATCH = /[’”\)\]\}]|(?<=[[:alpha:]\d])[\*_]|(?<=[\s^])['"]/
    end
  end
end
