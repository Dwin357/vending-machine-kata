require_relative '../components/coin_receptor.rb'

class VendingMachine
  attr_accessor :coin_tray

  def initialize
    @coin_tray = []
    @coin_receptor = CoinReceptor.new
  end

  def display
    coin_receptor.balance == 0 ? 'INSERT COINS' : coin_receptor.balance
  end

  def insert(coin)
    self.coin_tray << coin_receptor.insert(coin)
    coin_tray.compact!
    display
  end

  private

  attr_reader :coin_receptor
end