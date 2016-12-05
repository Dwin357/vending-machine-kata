def expect_subject_to_receive(command)
  allow_any_instance_of(Repl).to receive(command)
  expect_any_instance_of(Repl).to receive(command)
end

def allow_subject_to_receive(command)
  allow_any_instance_of(Repl).to receive(command)
end

def expect_object_to_receive(command)
  allow_any_instance_of(VendingMachine).to receive(command)
  expect_any_instance_of(VendingMachine).to receive(command)
end

def allow_object_to_receive(command)
  allow_any_instance_of(VendingMachine).to receive(command)
end

def suppress_output
  old_stdout = $stdout
  $stdout = StringIO.new '', 'w'
  yield
  $stdout.string
ensure
  $stdout = old_stdout
end

RSpec::Matchers.define :coin do |x|
  match { |actual| actual.type == x }
end
