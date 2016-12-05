require_relative '../components/coin_register'

class VendingMachine
  attr_accessor :coin_tray, :vending_tray

  def initialize
    @coin_tray     = []
    @coin_register = CoinRegister.new

    @vending_stock = initial_stock
    @vending_tray  = []

    @notice = nil
  end

  def display
    notice.nil? ? display_default : display_notice
  end

  def insert(coin)
    coin_tray << coin_register.insert(coin)
    coin_tray.compact!
    display
  end

  def coin_return
    make_change
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

  protected

  attr_reader :coin_register, :vending_stock
  attr_accessor :notice

  def vend(selection, price)
    make_sale(selection, price) if validate_sale(selection, price)
    display
  end

  def make_sale(selection, price)
    coin_register.sale(price)
    dispense(selection)
    make_change
    self.notice = 'THANK YOU'
  end

  def validate_sale(selection, price)
    unless sufficient_stock?(selection)
      self.notice = 'SOLD OUT'
      return false
    end
    unless sufficient_balance?(price)
      self.notice = 'PRICE $' + display_money(price)
      return false
    end
    true
  end

  def sufficient_stock?(selection)
    vending_stock[selection] > 0
  end

  def dispense(selection)
    vending_tray << decrement_stock(selection)
  end

  def decrement_stock(selection)
    vending_stock[selection] -= 1
    selection
  end

  def initial_stock
    {
      chips: 10,
      cola:  10,
      candy: 10
    }
  end

  def sufficient_balance?(amount)
    coin_register.balance >= amount
  end

  def make_change
    self.coin_tray += coin_register.make_change
  end

  def display_default
    coin_register.balance.zero? ? display_prompt : display_balance
  end

  def display_prompt
    coin_register.change_avaliable? ? 'INSERT COINS' : 'EXACT CHANGE ONLY'
  end

  def display_balance
    'Balance: $' + display_money(coin_register.balance)
  end

  def display_money(amount)
    format('%.2f', (amount / 100.0))
  end

  def display_notice
    message = notice
    self.notice = nil
    message
  end
end
