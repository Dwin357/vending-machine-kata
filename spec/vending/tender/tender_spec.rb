require_relative '../../../vending/tender/tender'

RSpec.describe 'LEGAL_TENDER' do
  subject { LEGAL_TENDER }

  it 'is immutable' do
    expect { subject[:fake] = { value: 1000 } }.to raise_error RuntimeError
  end
  it 'knows about pennies' do
    expect(subject).to have_key :penny
  end
  it 'knows about nickels' do
    expect(subject).to have_key :nickel
  end
  it 'knows about dimes' do
    expect(subject).to have_key :dime
  end
  it 'knows about quarters' do
    expect(subject).to have_key :quarter
  end

  describe 'penny' do
    subject { LEGAL_TENDER[:penny] }

    it 'is immutable' do
      expect { subject[:value] = 500 }.to raise_error RuntimeError
    end
    it 'has value of 1' do
      expect(subject[:value]).to eq 1
    end
    it 'has key properties' do
      expect(subject).to have_key :properties
    end
    describe 'properties' do
      subject { LEGAL_TENDER[:penny][:properties] }
      it 'is immutable' do
        expect { subject[:size] = 10 }.to raise_error RuntimeError
      end
      it 'has weight of 3' do
        expect(subject[:weight]).to eq 3
      end
      it 'has size of 3' do
        expect(subject[:size]).to eq 3
      end
    end
  end

  describe 'nickel' do
    subject { LEGAL_TENDER[:nickel] }

    it 'is immutable' do
      expect { subject[:value] = 500 }.to raise_error RuntimeError
    end
    it 'has value of 5' do
      expect(subject[:value]).to eq 5
    end
    it 'has key properties' do
      expect(subject).to have_key :properties
    end
    describe 'properties' do
      subject { LEGAL_TENDER[:nickel][:properties] }
      it 'is immutable' do
        expect { subject[:size] = 10 }.to raise_error RuntimeError
      end
      it 'has weight of 3' do
        expect(subject[:weight]).to eq 5
      end
      it 'has size of 3' do
        expect(subject[:size]).to eq 4
      end
    end
  end

  describe 'dime' do
    subject { LEGAL_TENDER[:dime] }

    it 'is immutable' do
      expect { subject[:value] = 500 }.to raise_error RuntimeError
    end
    it 'has value of 10' do
      expect(subject[:value]).to eq 10
    end
    it 'has key properties' do
      expect(subject).to have_key :properties
    end
    describe 'properties' do
      subject { LEGAL_TENDER[:dime][:properties] }
      it 'is immutable' do
        expect { subject[:size] = 10 }.to raise_error RuntimeError
      end
      it 'has weight of 1' do
        expect(subject[:weight]).to eq 1
      end
      it 'has size of 2' do
        expect(subject[:size]).to eq 2
      end
    end
  end

  describe 'quarter' do
    subject { LEGAL_TENDER[:quarter] }

    it 'is immutable' do
      expect { subject[:value] = 500 }.to raise_error RuntimeError
    end
    it 'has value of 25' do
      expect(subject[:value]).to eq 25
    end
    it 'has key properties' do
      expect(subject).to have_key :properties
    end
    describe 'properties' do
      subject { LEGAL_TENDER[:quarter][:properties] }
      it 'is immutable' do
        expect { subject[:size] = 10 }.to raise_error RuntimeError
      end
      it 'has weight of 7' do
        expect(subject[:weight]).to eq 7
      end
      it 'has size of 7' do
        expect(subject[:size]).to eq 7
      end
    end
  end
end
