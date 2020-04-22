# frozen_string_literal: true

RSpec.describe Formatter::PhoneNumber::UK do
  let(:described_class) { Formatter::PhoneNumber::UK }

  describe '#format' do
    context 'when its valid' do
      it 'formats the number when starting with 7' do
        valid_number = '7344567884'
        expect(described_class.format(valid_number)).to eq('+447344567884')
      end

      it 'formats the number when starting with 0' do
        valid_number = '07344567884'
        expect(described_class.format(valid_number)).to eq('+447344567884')
      end

      it 'formats the number when starting with 44' do
        valid_number = '447344567884'
        expect(described_class.format(valid_number)).to eq('+447344567884')
      end

      it 'formats the number when starting with +44' do
        valid_number = '+447344567884'
        expect(described_class.format(valid_number)).to eq('+447344567884')
      end

      it 'formats the number when valid and it has space' do
        valid_number = '44735 5605683'
        expect(described_class.format(valid_number)).to eq('+447355605683')
      end

      it 'formats when the number has multiple spaces' do
        valid_number = '+44  7  5 6  5 7 5 7 8 3 5'
        expect(described_class.format(valid_number)).to eq('+447565757835')
      end
    end

    context 'when its not valid' do
      it 'it raises an error when no number is given' do
        invalid = ''
        expect { described_class.format(invalid) }.to raise_error(RuntimeError)
      end

      it 'it raises an error when it doesnt start with 0 / 7 / 44 / +44' do
        invalid = '344567884'
        expect { described_class.format(invalid) }.to raise_error(RuntimeError)
      end

      it 'it raises an error when it has more than nine digits' do
        invalid = '4473354673444567884'
        expect { described_class.format(invalid) }.to raise_error(RuntimeError)
      end
      it 'it raises an error when it has not valid digits' do
        invalid = '44735x5605683'
        expect { described_class.format(invalid) }.to raise_error(RuntimeError)
      end

      it 'it raises an error when it has more than nine digits after prefix' do
        invalid = '44743444535667884'
        expect { described_class.format(invalid) }.to raise_error(RuntimeError)
      end
    end
  end
end
