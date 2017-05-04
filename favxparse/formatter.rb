module Favxparse
  class Formatter
    attr_reader :training

    CONTEXTS = [
      [:double_smart_quote, /“/,   '”'],
      [:double_quote,       /"/,   '\"'],
      [:single_smart_quote, /‘/,   '’'],
      [:single_quote,       /'/,   '\''],
      [:bold,               /\*$/, '*'],
      [:brackets,           /\[/,  ']'],
      [:parentheses,        /\(/,  ')'],
      [:braces,             /\{/,  '}']
    ]

    def initialize
      @training = {}
    end

    def format(tokens)
      [].tap do |result|
        stack = tokens.each.with_object([:start]) do |token, stack|
          next if ignore_closing?(token.to_s, stack)
          if token =~ /\n/
            close_context(stack.pop) { |t| result << t } while stack.any?
          end
          formatted = formatter(stack, token).format(token.to_s)
          result << ' ' if token.space_before?
          result << formatted
          update_stack(stack, token.to_s) { |t| result << t }
        end
        close_context(stack.pop) { |t| result << t } while stack.any?
      end.join('').strip
    end

    def learn(tokens)
      tokens.each.with_object([:start]) do |token, stack|
        learning = (training[token.to_s.downcase] ||= {})
        stack.each do |context|
          (learning[context] ||= []).push(match_format(token))
        end
        update_stack(stack, token.to_s)
      end
      self
    end

    def self.formatters
      @formatters ||= [
        Favxparse::Formatter::Uppercase.new,
        Favxparse::Formatter::Lowercase.new,
        Favxparse::Formatter::Capitalize.new,
        Favxparse::Formatter::Unchanged.new
      ]
    end

    private

    def match_format(token)
      self.class.formatters.detect { |f| f.match?(token.to_s) }
    end

    def update_stack(stack, token, &block)
      stack.pop if stack.last == :start
      CONTEXTS.each do |(context, start, stop)|
        if token.strip == stop
          while stack.any? && stack.last != context
            close_context(stack.last, &block) if block_given?
            stack.pop
          end
          stack.pop unless stack.empty?
        elsif token =~ start
          stack.push(context)
        end
      end
      stack.push(:start) if token =~ Token::END_SENTENCE
    end

    def close_context(context, &block)
      _, _, stop = CONTEXTS.detect { |name, _, _| name == context }
      yield stop if stop
    end

    def formatter(stack, token)
      stack.reverse.each do |context|
        learning = (training[token.to_s.downcase] || {})[context] || []
        return learning.sample if learning.any?
      end
      return self.class.formatters.last
    end

    def should_insert_space?(previous, token)
      return false unless previous.present? && token.present?
      previous =~ Token::SPACE_AFTER &&
        (token =~ Token::SPACE_BEFORE || token.first.ord > 0x10000) &&
        !(previous =~ /:\s*\z/ && token =~ /\A\d/)
    end

    def ignore_closing?(token, stack)
      name, _, _ = CONTEXTS.detect do |_, _, stop|
        !%w(' " *).include?(stop) && token.strip == stop
      end
      name && !stack.include?(name)
    end
  end
end
