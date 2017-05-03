module Favxparse
  module Token
    START_TEXT = :start
    END_TEXT = :end

    TOKEN_EXP = %r{(?:https?://[\w\./]+)|(([@#]?(?:\w+)(?:['’]\w+)*\b|((?:\.\.\.|\S)\s*|\n+)))}

    END_SENTENCE = /[\.\!\?‽…]+\s*/
    SPACE_BEFORE = /\A[\w$&#@>\+=—“‘\(\[\{]/
    SPACE_AFTER = /[\.,:\?\!‽…\w&#@>\+=”’\)\]\}]\z/
  end
end
