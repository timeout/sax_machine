require 'sax_machine/state_machine'
require 'sax_machine/transition'
require 'sax_machine/push_event'
require 'sax_machine/article'

RSpec.describe SaxMachine::StateMachine do
  describe '#initialize' do
    it 'has a default start_state of :nil' do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article))
      end
      expect(machine.state).to eq(:nil)
    end
  end

  describe '#on_state_element' do
    it 'pushes an article onto the stack', broken: true do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article))
      end
      machine.on_start_element(:article)
      expect(machine.stack.peek.name).to eq(:article)
    end

    it 'pops an article off the stack', broken: true do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article))
        t << SaxMachine::Transition
          .new(SaxMachine::PopEvent.new(:article))
      end
      machine.on_start_element(:article)
      machine.on_end_element(:article)
      expect(machine.stack.peek).to be_nil
    end

    it 'doesn\'t change the stack state', broken: true do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article))
        t << SaxMachine::Transition
          .new(SaxMachine::TextEvent.new(:title), :article)
      end
      machine.on_start_element(:article)
      machine.on_start_element(:title)
      expect(machine.stack.peek.name).to eq(:article)
    end
  end
end
