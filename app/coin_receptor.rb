LEGAL_TENDER = {
  penny:   { value:  1, weight: 3, size: 3}.freeze,
  nickel:  { value:  5, weight: 5, size: 4}.freeze,
  dime:    { value: 10, weight: 1, size: 2}.freeze,
  quarter: { value: 25, weight: 7, size: 7}.freeze
}.freeze


class Coin
  attr_reader :weight, :diameter

  def initialize(type)
    @weight   = LEGAL_TENDER.fetch(type).fetch(:weight)
    @diameter = LEGAL_TENDER.fetch(type).fetch(:size)
  end
end



class CoinReceptor
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def insert(coin)
    if valid? coin
      add_balance value_of coin
      nil
    else
      return coin
    end
  end

  private

  def add_balance(value)
    @balance += value
  end

  def valid?(coin)
    accepted_tender.any? do |standard|
      standard[:weight] == coin.weight && 
      standard[:size] == coin.diameter
    end
  end

  def value_of(coin)
    accepted_tender.find{|standard| standard[:weight] == coin.weight}[:value]
  end

  def accepted_tender
    tender = LEGAL_TENDER.dup
    tender.delete(:penny)
    tender.map{ |_, properties| properties }
  end
end