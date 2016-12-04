require_relative '../../../vending/tender/coin'
require_relative '../../../vending/tender/tender'

RSpec.describe Coin do

  subject { Coin.new(coin) }

  describe 'initialize' do
    let(:coin) { :nickel }

    it 'sets a weight attribute from legal tender' do
      expect(subject.weight).to eq LEGAL_TENDER.fetch(:nickel).fetch(:properties).fetch(:weight)
    end
    it 'sets a diameter attribute from legal tender' do
      expect(subject.diameter).to eq LEGAL_TENDER.fetch(:nickel).fetch(:properties).fetch(:size)
    end 
    it 'sets a type attribute from what is passed' do
      expect(subject.type).to eq :nickel
    end       
  end
end