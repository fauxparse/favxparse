module Favxparse
  class Formatter::Uppercase
    def match?(token)
      token.upcase == token && token =~ /\A\w+\z/
    end

    def format(token)
      token.upcase
    end
  end
end
