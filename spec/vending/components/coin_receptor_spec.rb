require_relative '../../../vending/components/coin_receptor'

RSpec.describe CoinReceptor do

  subject { CoinReceptor.new }

  let(:nickel)  { Coin.new(:nickel) }
  let(:penny)   { Coin.new(:penny) }
  let(:dime)    { Coin.new(:dime) }
  let(:quarter) { Coin.new(:quarter) }

  describe 'coin validation' do
    it 'return pennies' do
      expect(subject.insert(penny)).to eq penny
    end
    it 'accepts nickels' do
      expect(subject.insert(nickel)).to be nil
    end
    it 'accepts dimes' do
      expect(subject.insert(dime)).to be nil
    end
    it 'accepts quarters' do
      expect(subject.insert(quarter)).to be nil
    end
  end

  describe 'balance incrementation' do
    it 'pennies to not add balance' do
      expect{ subject.insert(penny)}.not_to change{ subject.balance }
    end
    it 'nickels add 5' do
      expect{ subject.insert(nickel) }
        .to change{ subject.balance }.from(0).to(5)
    end
    it 'dimes add 10' do
      expect{ subject.insert(dime) }
        .to change{ subject.balance }.from(0).to(10)
    end
    it 'quarters add 25' do
      expect{ subject.insert(quarter) }
        .to change{ subject.balance }.from(0).to(25)
    end
    it 'multiple coins build balance (not pennies)' do
      subject.insert(nickel)
      expect{ subject.insert(nickel) }
        .to change{ subject.balance }.from(5).to(10) 
      expect{ subject.insert(dime) }
        .to change{ subject.balance }.from(10).to(20)           
      expect{ subject.insert(quarter) }
        .to change{ subject.balance }.from(20).to(45)
      expect{ subject.insert(penny) }.not_to change{ subject.balance }
    end
  end

  describe 'sale' do
    before(:each) { subject.insert(dime) }
    it 'deducts amount from balance' do
      expect{ subject.sale(5) }.to change{ subject.balance }.from(10).to(5)
    end
  end
end