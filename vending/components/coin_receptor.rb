require_relative '../tender/coin'

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

  def sale(amount)
    subtract_balance(amount)
  end

  def make_change
    change = []
    while balance > 0 do
      case 
      when balance >= 25
        subtract_balance(25)
        change << Coin.new(:quarter)
      when balance >= 10
        subtract_balance(10)
        change << Coin.new(:dime)
      when balance >= 5
        subtract_balance(5)
        change << Coin.new(:nickel)
      end
    end
    change
  end

  private

  def add_balance(amount)
    @balance += amount
  end

  def subtract_balance(amount)
    @balance -= amount
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