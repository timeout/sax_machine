require 'sax_machine/state_machine'
require 'sax_machine/transition'
require 'sax_machine/push_event'
require 'sax_machine/article'

RSpec.describe SaxMachine::StateMachine do
  describe '#on_state_element' do
    it 'pushes an article onto the stack' do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article), nil)
      end
      machine.on_start_element(:article)
      expect(machine.stack.peek.name).to eq(:article)
    end

    it 'pops an article off the stack', broken: true do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article), nil)
        t << SaxMachine::Transition
          .new(SaxMachine::PopEvent.new(:article), nil)
      end
      machine.on_start_element(:article)
      machine.on_end_element(:article)
      expect(machine.stack.peek).to be_nil
    end

    it 'doesn\'t change the stack state', broken: true do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article), nil)
        t << SaxMachine::Transition
          .new(SaxMachine::TextEvent.new(:title), :article)
      end
      machine.on_start_element(:article)
      machine.on_start_element(:title)
      expect(machine.stack.peek.name).to eq(:article)
    end
  end
end
