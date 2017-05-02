module Favxparse
  class Formatter::Capitalize
    def match?(token)
      token.capitalize == token && token =~ /\A\w+\z/
    end

    def format(token)
      token.capitalize
    end
  end
end
