require_relative '../machine/vending_machine'
require_relative '../tender/coin'
require_relative '../tender/tender'

class Repl
  attr_accessor :active_command, :object, :command_options, :response

  def initialize(object)
    @object = object
    @response
    @active_command
    @command_options
  end

  def repl
    display greeting_text
    while true do
      read
      break if exit?
      execute
      printt
    end
  end

  def printt
    puts '-' * 9
    display "Screen: #{response}\n"
    display "Coin Tray: #{object.coin_tray}\n"
    display "Vending Tray: #{object.vending_tray}\n"
    puts '-' * 9
  end

  def read
    clear_old_values
    display prompt_text
    parse_command
  end

  def prompt_text
    "\n >"
  end

  def greeting_text
    "\nWelcome to the repel\nyou can type 'exit' to exit\nor 'help' for a list of commands"
  end

  def execute
    return help if help?
    return ex_command if command_dictionary.has_key?(active_command)
    return ex_alias if alias_dictionary.has_key?(active_command)
    self.response = "Error: #{active_command} not found, type 'help' for list of valid commands"
  end

  def user_input
    gets.chomp
  end

  def parse_command
    input = user_input.split(' ')
    self.active_command = input.shift
    input.each do |option|
      self.command_options[option] += 1
    end
  end

  def clear_old_values
    self.response = ''
    self.active_command = ''
    self.command_options = Hash.new(0)
  end

  def display(text)
    print text
  end

  def exit?
    active_command == 'exit' || active_command == '-e'
  end

  def help?
    active_command == 'help' || active_command == '-h'
  end

  def help
    dictionary = command_dictionary.dup
    alias_dictionary.each do |als, name|
      dictionary[name][:alias] = [] unless dictionary[name][:alias]
      dictionary[name][:alias] << als
    end

    self.response = dictionary
  end

  def ex_command
    call active_command
  end

  def ex_alias
    call(alias_dictionary[active_command])
  end

  def call(command)
    if command_dictionary[command][:arg].nil?
      self.response = object.send(command) 
    else
      opt = option_dictionary[command_options.keys.first]
      self.response = object.send(command, opt)
    end
  end

  def command_dictionary
    {
      'display' =>      { method: :display, arg: nil, options: nil },
      'insert' =>       { method: :insert, arg: :coin, options: ['-p','-n','-d','-q']},
      'return' =>       { method: :coin_return, arg: nil, options: nil},
      'cola' =>         { method: :cola, arg: nil, options: nil},
      'chips' =>        { method: :chips, arg: nil, options: nil},            
      'candy' =>        { method: :candy, arg: nil, options: nil},
      'coin_tray' =>    { method: :coin_tray, arg: nil, options: nil},
      'vending_tray' => { method: :vending_tray, arg: nil, options: nil}
    }
  end

  def alias_dictionary
    {
      'dis' => 'display',
      'in'  => 'insert',
      'rtn' => 'return',
      'la'  => 'cola',
      'ps'  => 'chips',
      'dy'  => 'candy',
      'c_t' => 'coin_tray',
      'v_t' => 'vending_tray'
    }
  end

  def option_dictionary
    {
      '-q' => Coin.new(:quarter),
      '-d' => Coin.new(:dime),
      '-n' => Coin.new(:nickel),
      '-p' => Coin.new(:penny)
    }
  end
end
