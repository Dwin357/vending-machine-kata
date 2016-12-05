require_relative '../../../vending/components/repl'
require_relative '../../../vending/machine/vending_machine'
require_relative '../support/repel_support'

RSpec.describe Repl do
  subject { Repl.new(machine) }

  describe 'read' do
    describe 'clears old command values' do
      before do
        allow_subject_to_receive(:user_input).and_return('exit')
        subject.tap do |sub|
          sub.response = response_msg
          sub.error = error_msg
          sub.active_command = old_command
          sub.command_options = old_options
        end
      end

      it 'clears old response' do
        expect { suppress_output { subject.read } }
          .to change { subject.response }.from(response_msg).to('')
      end
      it 'nils old error' do
        expect { suppress_output { subject.read } }
          .to change { subject.error }.from(error_msg).to(nil)
      end
      it 'clears old command' do
        expect { suppress_output { subject.read } }
          .to change { subject.active_command }.from(old_command).to('exit')
      end
      it 'clears old options' do
        expect { suppress_output { subject.read } }
          .to change { subject.command_options }.from(old_options).to Hash.new 0
      end
    end
    describe 'input parsing' do
      before do
        allow_subject_to_receive(:user_input).and_return('foo bar bar baz')
      end
      it 'sets first word as active command' do
        expect { suppress_output { subject.read } }
          .to change { subject.active_command }.from('').to('foo')
      end
      it 'sets all later words as keys of incrementing hash' do
        expect { suppress_output { subject.read } }
          .to change { subject.command_options }.to('bar' => 2, 'baz' => 1)
      end
    end
  end

  describe 'evaluate' do
    describe 'display' do
      before do
        allow_subject_to_receive(:user_input).and_return('display', 'exit')
      end
      it 'calls display on object' do
        expect_object_to_receive(:display).once
        suppress_output { subject.repl }
      end
    end
    describe 'dis' do
      before do
        allow_subject_to_receive(:user_input).and_return('dis', 'exit')
      end
      it 'calls display on object' do
        expect_object_to_receive(:display).once
        suppress_output { subject.repl }
      end
    end
    describe 'return' do
      before do
        allow_subject_to_receive(:user_input).and_return('return', 'exit')
      end
      it 'calls coin_return on object' do
        expect_object_to_receive(:coin_return).once
        suppress_output { subject.repl }
      end
    end
    describe 'rtn' do
      before do
        allow_subject_to_receive(:user_input).and_return('rtn', 'exit')
      end
      it 'calls coin_return on object' do
        expect_object_to_receive(:coin_return).once
        suppress_output { subject.repl }
      end
    end
    describe 'cola' do
      before do
        allow_subject_to_receive(:user_input).and_return('cola', 'exit')
      end
      it 'calls cola on object' do
        expect_object_to_receive(:cola).once
        suppress_output { subject.repl }
      end
    end
    describe 'la' do
      before do
        allow_subject_to_receive(:user_input).and_return('la', 'exit')
      end
      it 'calls cola on object' do
        expect_object_to_receive(:cola).once
        suppress_output { subject.repl }
      end
    end
    describe 'chips' do
      before do
        allow_subject_to_receive(:user_input).and_return('chips', 'exit')
      end
      it 'calls chips on object' do
        expect_object_to_receive(:chips).once
        suppress_output { subject.repl }
      end
    end
    describe 'ps' do
      before do
        allow_subject_to_receive(:user_input).and_return('ps', 'exit')
      end
      it 'calls chips on object' do
        expect_object_to_receive(:chips).once
        suppress_output { subject.repl }
      end
    end
    describe 'candy' do
      before do
        allow_subject_to_receive(:user_input).and_return('candy', 'exit')
      end
      it 'calls candy on object' do
        expect_object_to_receive(:candy).once
        suppress_output { subject.repl }
      end
    end
    describe 'dy' do
      before do
        allow_subject_to_receive(:user_input).and_return('dy', 'exit')
      end
      it 'calls candy on object' do
        expect_object_to_receive(:candy).once
        suppress_output { subject.repl }
      end
    end
    describe 'insert' do
      context 'with -q option' do
        before do
          allow_subject_to_receive(:user_input).and_return('insert -q', 'exit')
        end
        it 'calls insert passing a quarter' do
          expect_object_to_receive(:insert).with(coin(:quarter))
          suppress_output { subject.repl }
        end
      end
      context 'with -d option' do
        before do
          allow_subject_to_receive(:user_input).and_return('insert -d', 'exit')
        end
        it 'calls insert passing a dime' do
          expect_object_to_receive(:insert).with(coin(:dime))
          suppress_output { subject.repl }
        end
      end
      context 'with -n option' do
        before do
          allow_subject_to_receive(:user_input).and_return('insert -n', 'exit')
        end
        it 'calls insert passing a nickel' do
          expect_object_to_receive(:insert).with(coin(:nickel))
          suppress_output { subject.repl }
        end
      end
      context 'with -p option' do
        before do
          allow_subject_to_receive(:user_input).and_return('insert -p', 'exit')
        end
        it 'calls insert passing a penny' do
          expect_object_to_receive(:insert).with(coin(:penny))
          suppress_output { subject.repl }
        end
      end
    end
    describe 'in' do
      context 'with -q option' do
        before do
          allow_subject_to_receive(:user_input).and_return('in -q', 'exit')
        end
        it 'calls insert passing a quarter' do
          expect_object_to_receive(:insert).with(coin(:quarter))
          suppress_output { subject.repl }
        end
      end
      context 'with -d option' do
        before do
          allow_subject_to_receive(:user_input).and_return('in -d', 'exit')
        end
        it 'calls insert passing a dime' do
          expect_object_to_receive(:insert).with(coin(:dime))
          suppress_output { subject.repl }
        end
      end
      context 'with -n option' do
        before do
          allow_subject_to_receive(:user_input).and_return('in -n', 'exit')
        end
        it 'calls insert passing a nickel' do
          expect_object_to_receive(:insert).with(coin(:nickel))
          suppress_output { subject.repl }
        end
      end
      context 'with -p option' do
        before do
          allow_subject_to_receive(:user_input).and_return('in -p', 'exit')
        end
        it 'calls insert passing a penny' do
          expect_object_to_receive(:insert).with(coin(:penny))
          suppress_output { subject.repl }
        end
      end
    end
  end

  describe 'print' do
    describe 'greeting' do
      context 'with two commands' do
        before do
          allow_subject_to_receive(:user_input).and_return('help', 'exit')
        end
        it 'dispalys once' do
          expect_subject_to_receive(:puts).with(greeting_text).once
          suppress_output { subject.repl }
        end
      end
      context 'with one command' do
        before do
          allow_subject_to_receive(:user_input).and_return('exit')
        end
        it 'dispalys once' do
          expect_subject_to_receive(:puts).with(greeting_text).once
          suppress_output { subject.repl }
        end
      end
    end

    describe 'vending view' do
      context 'when no error present' do
        before do
          allow_subject_to_receive(:response).and_return(response_msg)
          allow_subject_to_receive(:user_input).and_return('help', 'exit')
        end
        it 'is called' do
          expect_subject_to_receive(:vending_view).once
          suppress_output { subject.repl }
        end
        it 'includes response' do
          expect(subject.vending_view).to include response_msg
        end
      end
      context 'with error present' do
        before do
          allow_subject_to_receive(:error).and_return(error_msg)
          allow_subject_to_receive(:user_input).and_return('help', 'exit')
        end
        it 'is not called' do
          expect_any_instance_of(Repl).not_to receive(:vending_view)
          suppress_output { subject.repl }
        end
      end
    end

    describe 'error view' do
      context 'with an error present' do
        before do
          allow_subject_to_receive(:error).and_return(error_msg)
          allow_subject_to_receive(:user_input).and_return('help', 'exit')
        end
        it 'is called' do
          expect_subject_to_receive(:error_view).once
          suppress_output { subject.repl }
        end
        it 'includes error' do
          expect(subject.error_view).to include error_msg
        end
      end
      context 'with no error present' do
        before do
          allow_subject_to_receive(:response).and_return(response_msg)
          allow_subject_to_receive(:user_input).and_return('help', 'exit')
        end
        it 'is not called' do
          expect_any_instance_of(Repl).not_to receive(:error_view)
          suppress_output { subject.repl }
        end
      end
    end
  end

  describe 'loop' do
    context 'with one command' do
      before { allow_subject_to_receive(:user_input).and_return('exit') }

      it 'displays the prompt once' do
        expect_subject_to_receive(:prompt).once
        suppress_output { subject.repl }
      end
    end
    context 'with two commands' do
      before do
        allow_subject_to_receive(:user_input).and_return('help', 'exit')
      end

      it 'displays the prompt twice' do
        expect_subject_to_receive(:prompt).twice
        suppress_output { subject.repl }
      end
    end
  end

  let(:error_msg) { SecureRandom.hex(5) }
  let(:response_msg) { SecureRandom.hex(5) }
  let(:old_command) { SecureRandom.hex(5) }
  let(:old_options) { { a: SecureRandom.hex(5), b: SecureRandom.hex(5) } }

  let(:machine) { VendingMachine.new }

  let(:greeting_text) do
    "Welcome to the repel\nyou can type 'exit' " \
      "to exit\nor 'help' for a list of commands"
  end
end
