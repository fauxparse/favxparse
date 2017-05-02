require 'cgi'

module Favxparse
  class Tokeniser
    def initialize(text)
      @text = CGI::unescapeHTML(text)
    end

    def tokens
      @tokens ||= tokenise(@text)
    end

    private

    def tokenise(text)
      text.scan(Token::TOKEN_EXP).map(&:first).compact
    end
  end
end
