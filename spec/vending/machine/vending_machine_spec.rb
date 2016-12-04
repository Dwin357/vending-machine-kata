require_relative '../../../vending/machine/vending_machine'

RSpec.describe VendingMachine do

  subject { VendingMachine.new }

  let(:nickel)  { Coin.new(:nickel) }
  let(:penny)   { Coin.new(:penny) }
  let(:dime)    { Coin.new(:dime) }
  let(:quarter) { Coin.new(:quarter) }

  describe 'insert coin' do
    before(:each) do
      # put a pen in the coin try...  b/c we can
      subject.coin_tray << 'pen'
    end
    context 'a penny' do
      it 'returns the penny to the coin tray' do
        expect{ subject.insert(penny) }
          .to change{ subject.coin_tray }.from(['pen']).to(['pen', penny])
      end
      it 'displays INSERT COINS after inserting' do
        subject.insert(penny)
        expect(subject.display).to eq 'INSERT COINS'
      end
    end

    context 'a nickel' do
      before(:each) do
        # add a quarter... b/c we can
        subject.insert quarter
      end
      it 'does not change the coin tray' do
        expect{ subject.insert nickel }.not_to change{ subject.coin_tray }
      end
      it 'adds 5 to display balance' do
        expect{ subject.insert nickel }.to change{ subject.display }
          .from('Balance: $0.25').to('Balance: $0.30')
      end
    end

    context 'a dime' do
      before(:each) do
        # add a quarter... b/c we can
        subject.insert quarter
      end
      it 'does not change the coin tray' do
        expect{ subject.insert dime }.not_to change{ subject.coin_tray }
      end
      it 'adds 10 to display balance' do
        expect{ subject.insert dime }.to change{ subject.display }
          .from('Balance: $0.25').to('Balance: $0.35')
      end
    end

    context 'a quarter' do
      before(:each) do
        # add a dime... b/c we can
        subject.insert dime
      end
      it 'does not change the coin tray' do
        expect{ subject.insert quarter }.not_to change{ subject.coin_tray }
      end
      it 'adds 5 to display balance' do
        expect{ subject.insert quarter }.to change{ subject.display }
          .from('Balance: $0.10').to('Balance: $0.35')
      end
    end
  end
end