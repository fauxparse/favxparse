module Favxparse
  class Formatter::Lowercase
    def match?(token)
      token.downcase == token && token =~ /\A\w+\z/
    end

    def format(token)
      token.downcase
    end
  end
end
