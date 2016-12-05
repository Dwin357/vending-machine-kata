require_relative '../tender/coin'

class CoinRegister
  attr_reader :balance

  def initialize
    @balance = 0

    @coin_stock = initial_stock
  end

  def insert(coin)
    if valid? coin
      stash_coin coin
      add_balance value_of coin
      nil
    else
      coin
    end
  end

  def sale(amount)
    subtract_balance(amount)
  end

  def make_change
    change = []
    while balance > 0
      if balance >= 25
        subtract_balance(25)
        change << dispense_coin(:quarter)
      elsif balance >= 10
        subtract_balance(10)
        change << dispense_coin(:dime)
      elsif balance >= 5
        subtract_balance(5)
        change << dispense_coin(:nickel)
      end
    end
    change
  end

  def change_avaliable?
    # since denomenations are constants, these combinations do not need to be
    # progrmatically derived, but the the general formula for this would be
    # from (highest denomenation - lowest denomenation)
    # to zero
    # step lowest denomentation
    # perform |value|
    #   assert value exactly acheivible w/ coin_stock
    coin_stock[:nickel].size > 1 &&
      coin_stock[:dime].size > 1 &&
      (coin_stock[:nickel].size > 2 || coin_stock[:dime].size > 2)
  end

  protected

  attr_reader :coin_stock

  def initial_stock
    {
      nickel:  Array.new(10).map { Coin.new(:nickel) },
      dime:    Array.new(10).map { Coin.new(:dime) },
      quarter: Array.new(10).map { Coin.new(:quarter) }
    }
  end

  def add_balance(amount)
    @balance += amount
  end

  def subtract_balance(amount)
    @balance -= amount
  end

  def dispense_coin(type)
    coin_stock[type].pop
  end

  def stash_coin(coin)
    coin_stock[type_of(coin)] << coin
  end

  def valid?(coin)
    accepted_tender.map { |_, atrib| atrib[:properties] }.any? do |known|
      known[:weight] == coin.weight &&
        known[:size] == coin.diameter
    end
  end

  def value_of(coin)
    accepted_tender[type_of(coin)][:value]
  end

  def type_of(coin)
    type, = accepted_tender.find do |_, known|
      known[:properties] == { weight: coin.weight, size: coin.diameter }
    end
    type
  end

  def accepted_tender
    tender = LEGAL_TENDER.dup
    tender.delete(:penny)
    tender
  end
end
