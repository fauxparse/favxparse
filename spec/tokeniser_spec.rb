require 'spec_helper'

describe Favxparse::Tokeniser do
  subject(:tokeniser) { Favxparse::Tokeniser.new(text) }

  describe '#tokens' do
    subject(:tokens) { tokeniser.tokens }
    let(:token_types) do
      tokens.map { |t| t.class.name.demodulize.underscore.to_sym }
    end

    context 'for a simple tweet' do
      let(:text) { 'This is a test.' }

      it 'produces the correct symbol types' do
        expect(token_types).to eq %i[
          word
          word
          word
          word
          single_character
        ]
      end

      it 'saves space information' do
        expect(tokens.map(&:space_before?)).to eq [
          false, true, true, true, false
        ]
      end
    end

    context 'for a simple tweet' do
      let(:text) do
        <<~EOS
          [on a date]
          me: *sweats*
          waiter: 😓
        EOS
      end

      it 'produces the correct symbol types' do
        expect(token_types).to eq %i[
          single_character
          word
          word
          word
          single_character
          new_line
          word
          single_character
          single_character
          word
          single_character
          new_line
          word
          single_character
          emoji
        ]
      end
    end
  end
end
