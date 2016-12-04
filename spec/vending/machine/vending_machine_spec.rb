require_relative '../../../vending/machine/vending_machine'

RSpec.describe VendingMachine do

  subject { VendingMachine.new }

  let(:nickel)  { Coin.new(:nickel) }
  let(:penny)   { Coin.new(:penny) }
  let(:dime)    { Coin.new(:dime) }
  let(:quarter) { Coin.new(:quarter) }

  describe '#insert(coin)' do
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
      it 'adds 25 to display balance' do
        expect{ subject.insert quarter }.to change{ subject.display }
          .from('Balance: $0.10').to('Balance: $0.35')
      end
    end
  end

  describe '#display' do
    context 'with a notice and no balance' do
      before{ subject.send(:notice=, 'message') }
      it 'displays the message exactly once' do
        expect(subject.display).to eq 'message'
        expect(subject.display).not_to eq 'message'
      end
    end
    context 'with a notice and a balance' do
      before do
        subject.insert(dime)
        subject.send(:notice=, 'message')
      end
      it 'displays the message exactly once' do
        expect(subject.display).to eq 'message'
        expect(subject.display).not_to eq 'message'
      end      
    end
    context 'with no message' do
      context 'and no balance' do
        it 'displays default prompt repeatedly' do
          expect(subject.display).to eq 'INSERT COINS'
          expect(subject.display).to eq 'INSERT COINS'          
        end
      end
      context 'and a balance' do
        before { subject.insert(dime) }
        it 'displays the balance repeatedly' do
          expect(subject.display).to eq 'Balance: $0.10'
          expect(subject.display).to eq 'Balance: $0.10'
        end
      end
    end
  end

  describe '#cola' do
    context 'with enough money' do
      before { 5.times{ subject.insert(quarter) } }
      it "says 'THANK YOU'" do
        expect(subject.cola).to eq 'THANK YOU'
      end
      it 'adds :cola in vending tray' do
        expect{ subject.cola }.to change{ subject.vending_tray }
          .from([]).to([:cola])
      end
    end

    context 'with insufficient money' do
      it "says 'PRICE $1.00'" do
        expect(subject.cola).to eq 'PRICE $1.00'
      end
      it 'does not change vending tray' do
        expect{subject.cola}.not_to change{ subject.vending_tray }
      end
    end
  end

  describe '#chips' do
    context 'with enough money' do
      before { 6.times { subject.insert(dime) } }
      it "says 'THANK YOU'" do
        expect(subject.chips).to eq 'THANK YOU'
      end
      it 'adds :chips in vending tray' do
        expect{ subject.chips }.to change{ subject.vending_tray }
          .from([]).to([:chips])
      end
    end

    context 'with insufficient money' do
      it "says 'PRICE $0.50'" do
        expect(subject.chips).to eq 'PRICE $0.50'
      end
      it 'does not change vending tray' do
        expect{subject.chips}.not_to change{ subject.vending_tray }
      end
    end
  end

  describe '#candy' do
    context 'with enough money' do
      before { 3.times { subject.insert(quarter) } }
      it "says 'THANK YOU'" do
        expect(subject.candy).to eq 'THANK YOU'
      end
      it 'adds :candy in vending tray' do
        expect{ subject.candy }.to change{ subject.vending_tray }
          .from([]).to([:candy])
      end
    end

    context 'with insufficient money' do
      it "says 'PRICE $0.65'" do
        expect(subject.candy).to eq 'PRICE $0.65'
      end
      it 'does not change vending tray' do
        expect{subject.candy}.not_to change{ subject.vending_tray }
      end
    end
  end
end