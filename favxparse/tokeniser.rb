require 'cgi'

module Favxparse
  class Tokeniser
    def initialize(text)
      @text = CGI::unescapeHTML(text.strip)
    end

    def tokens
      @tokens ||= tokenise(@text)
    end

    private

    def tokenise(text)
      [].tap do |tokens|
        index = 0
        while index < text.length
          token = Token.match(text, index)
          token.space_before = tokens.last.try(:space?)
          tokens << token
          index += token.length
        end
        tokens.reject!(&:skip?)
      end
    end
  end
end
