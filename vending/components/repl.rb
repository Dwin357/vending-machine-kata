require_relative '../machine/vending_machine'
require_relative '../tender/coin'
require_relative '../tender/tender'

class Repl
  attr_accessor :active_command, :object, :command_options, :response, :error

  def initialize(object)
    @object = object
    @response = ''
    @error = nil
    @active_command = ''
    @command_options = Hash.new(0)
  end

  def repl
    puts greeting_text
    loop do
      read
      break if exit?
      execute
      puts output
    end
  end

  def output
    error.nil? ? vending_view : error_view
  end

  def read
    clear_old_values
    prompt
    parse_command
  end

  def prompt
    print "\n >"
  end

  def greeting_text
    [
      'Welcome to the repel',
      "you can type 'exit' to exit",
      "or 'help' for a list of commands"
    ].join("\n")
  end

  def execute
    return help if help?
    return ex_command if command_dictionary.key?(active_command)
    return ex_alias if alias_dictionary.key?(active_command)
    self.error =
      "#{active_command} not found, type 'help' for list of valid commands"
  end

  def user_input
    gets.chomp
  end

  def parse_command
    input = user_input.split(' ')
    self.active_command = input.shift
    input.each do |option|
      command_options[option] += 1
    end
  end

  def clear_old_values
    self.error = nil
    self.response = ''
    self.active_command = ''
    self.command_options = Hash.new(0)
  end

  def vending_view
    [
      '-' * 9,
      "Screen: #{response}",
      "Coin Tray: #{object.coin_tray}",
      "Vending Tray: #{object.vending_tray}",
      '-' * 9
    ].join("\n")
  end

  def error_view
    "Error: #{error}"
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

  def call(command_string)
    command = command_dictionary[command_string]
    if command[:arg].nil?
      self.response = object.send(command[:method])
    else
      opt = option_dictionary[command_options.keys.first]
      self.response = object.send(command[:method], opt)
    end
  end

  def command_dictionary
    {
      'display' =>      { method: :display, arg: nil, options: nil },
      'insert' =>       {
        method: :insert,
        arg: :coin,
        options: ['-p', '-n', '-d', '-q']
      },
      'return' =>       { method: :coin_return, arg: nil, options: nil },
      'cola' =>         { method: :cola, arg: nil, options: nil },
      'chips' =>        { method: :chips, arg: nil, options: nil },
      'candy' =>        { method: :candy, arg: nil, options: nil }
    }
  end

  def alias_dictionary
    {
      'dis' => 'display',
      'in'  => 'insert',
      'rtn' => 'return',
      'la'  => 'cola',
      'ps'  => 'chips',
      'dy'  => 'candy'
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
