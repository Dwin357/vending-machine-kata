require_relative '../components/coin_receptor.rb'

class VendingMachine
  attr_accessor :coin_tray, :vending_tray

  def initialize
    @coin_tray = []
    @vending_tray = []
    @coin_receptor = CoinReceptor.new
    @notice = nil
  end

  def display
    notice.nil? ? display_default : display_notice
  end

  def insert(coin)
    self.coin_tray << coin_receptor.insert(coin)
    coin_tray.compact!
    display
  end

  def cola
    vend(:cola, 100)
  end

  def chips
    vend(:chips, 50)
  end

  def candy
    vend(:candy, 65)
  end

  private

  attr_reader :coin_receptor
  attr_accessor :notice

  def balance_display
    'Balance: $' + display_money(coin_receptor.balance)
  end

  def display_money(amount)
    # hack that needs to be cleaned up
    # need to look up float/string methods, but no internet at the moment
    formated = (amount / 100.0).to_s
    formated += '0' if formated[-2] == '.'
    formated
  end

  def vend(selection, price)
    if sufficient_balance?(price)
      coin_receptor.sale(price)
      dispense(selection)
      self.notice = 'THANK YOU'
    else
      self.notice = 'PRICE $' + display_money(price)
    end
    display
  end

  def dispense(selection)
    vending_tray << selection
  end

  def display_default
    coin_receptor.balance == 0 ? 'INSERT COINS' : balance_display
  end

  def sufficient_balance?(amount)
    coin_receptor.balance >= amount
  end

  def display_notice
    message = notice
    self.notice = nil
    message
  end
end