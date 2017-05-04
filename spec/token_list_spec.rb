require 'spec_helper'

describe Favxparse::TokenList do
  subject(:token_list) { Favxparse::TokenList.new }
  let(:output) { token_list.join }

  context 'with some tokens' do
    before do
      Favxparse::Tokeniser.new(input).each { |t| token_list << t }
      token_list << Favxparse::Token::End.new
    end

    context 'with balanced parentheses' do
      let(:input) { '(())' }
      it 'closes parentheses automatically' do
        expect(output).to eq input
      end
    end

    context 'with unbalanced parentheses' do
      let(:input) { '([(])' }
      it 'closes parentheses automatically' do
        expect(output).to eq '([()])'
      end
    end

    context 'with hanging emphasis' do
      let(:input) { '*omg' }
      it 'inserts a closing asterisk' do
        expect(output).to eq '*omg*'
      end
    end
  end
end
