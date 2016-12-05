require_relative 'vending/machine/vending_machine'
require_relative 'vending/components/repl'

Repl.new(VendingMachine.new).repl
