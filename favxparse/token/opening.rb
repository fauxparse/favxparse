module Favxparse
  module Token
    class Opening < Base
      MATCH = /[‘“\(\[\{]|[\*_](?=[[:alpha:]\d])|(?<=[\s^])['"]/

      CLOSING = {
        '‘' => '’',
        '“' => '”',
        '\'' => '\'',
        '"' => '"',
        '(' => ')',
        '[' => ']',
        '{' => '}',
        '*' => '*',
        '_' => '_'
      }

      def open?
        true
      end

      def close
        SingleCharacter.new(CLOSING[text] || text)
      end
    end
  end
end
