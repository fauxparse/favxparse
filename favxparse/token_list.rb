module Favxparse
  class TokenList
    def initialize(tokens = [])
      @tokens = tokens
      @stack = []
    end

    def <<(token)
      case token
      when Token::End then close_all
      else add_token_with_nesting(token)
      end
      self
    end

    def join
      tokens.join('')
    end

    delegate :each, :map, :[], :first, :last, to: :tokens

    private

    attr_reader :tokens, :stack

    def add_token_with_nesting(token)
      case token
      when Token::NewLine then close_all(token)
      when Token::Opening then open(token)
      when Token::Closing then close_until(token)
      else insert(token)
      end
    end

    def open(token)
      insert(token)
      stack.unshift(token)
    end

    def close_all(token = nil)
      while !stack.empty?
        insert(stack.shift.close)
      end
      insert(token) if token
    end

    def close_until(token)
      while !stack.empty?
        closing = stack.shift.close
        insert(closing)
        break if token == closing
      end
    end

    def insert(token)
      tokens << Token::Space.new if token.space_before?
      tokens << token
    end
  end
end
