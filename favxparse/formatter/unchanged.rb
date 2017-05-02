module Favxparse
  class Formatter::Unchanged
    def match?(token)
      true
    end

    def format(token)
      token
    end
  end
end
