module Favxparse
  module Token
    START_TEXT = :start
    END_TEXT = :end

    TOKEN_EXP = %r{(?:https?://[\w\./]+)|(([@#]?(?:\w+)(?:['’]\w+)*\b|((?:\.\.\.|\S)[ ]*|\n+)))}

    END_SENTENCE = /[\.\!\?‽…]+\s*/

    def self.match(text, index)
      tokens.lazy.map { |klass| klass.match(text, index) }.detect(&:present?)
    end

    def self.tokens
      [
        Url,
        Hashtag,
        Username,
        NewLine,
        Number,
        Word,
        Space,
        Emoji,
        SingleCharacter
      ]
    end
  end
end
