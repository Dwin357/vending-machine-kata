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