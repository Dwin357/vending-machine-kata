require_relative '../components/coin_receptor.rb'

class VendingMachine
  attr_accessor :coin_tray

  def initialize
    @coin_tray = []
    @coin_receptor = CoinReceptor.new
  end

  def display
    coin_receptor.balance == 0 ? 'INSERT COINS' : balance_display
  end

  def insert(coin)
    self.coin_tray << coin_receptor.insert(coin)
    coin_tray.compact!
    display
  end

  private

  attr_reader :coin_receptor

  def balance_display
    # hack that needs to be cleaned up
    # need to look up float/string methods, but no internet at the moment
    balance = (coin_receptor.balance / 100.0).to_s
    balance += '0' if balance[-2] == '.'
    'Balance: $' + balance
  end
end