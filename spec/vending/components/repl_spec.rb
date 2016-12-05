require_relative '../../../vending/components/repl'
require_relative '../../../vending/machine/vending_machine'


RSpec.describe Repl do

  subject { Repl.new(machine) }

  xdescribe 'repl' do
    context 'without an active command' do
      it 'displays the prompt' do
        expect{ subject.repl }.to output(' >').to_stdout
      end
    end

    context 'with "wow" command' do
      before { allow(subject).to receive(:gets).and_return("wow\n") }

      it 'tst' do
        expect{ subject.repl }.to change{ subject.send(:active_command)}.to('wow')
      end
    end
  end

  let(:machine) { VendingMachine.new }
end