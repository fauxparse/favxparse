module Favxparse
  module Token
    class Word < Base
      MATCH = /[[:alpha:]\d_]+(['’][[:alpha:]]+)*/
    end
  end
end
