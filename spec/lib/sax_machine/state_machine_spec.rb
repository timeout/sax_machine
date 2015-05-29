require 'sax_machine/state_machine'
require 'sax_machine/transition'
require 'sax_machine/push_event'
require 'sax_machine/article'
require 'sax_machine/front'

RSpec.describe SaxMachine::StateMachine do
  describe '#initialize' do
    it 'has a default start_state of :nil' do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article))
      end
      expect(machine.state_name).to eq(:nil)
    end
  end

  describe '#state_name' do
    it 'delegates to State#name' do 
      transition = SaxMachine::Transition
        .new(SaxMachine::PushEvent.new(:article))
      machine = SaxMachine::StateMachine.new do |t|
        t << transition
      end
      expect(machine.state_name).to eq(transition.state_name)
    end
  end

  describe '#on_start_element' do
    describe 'a PushEvent transition' do
      it 'pushes an article onto the stack' do
        machine = SaxMachine::StateMachine.new do |t|
          t << SaxMachine::Transition
            .new(SaxMachine::PushEvent.new(:article))
        end
        machine.on_start_element(:article)
        expect(machine.stack.peek.name).to eq(:article)
      end
    end

    describe 'a TextEvent' do
      it 'doesn\'t change the stack state' do
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

  describe '#on_end_element' do
    describe 'a PopEvent' do
      it 'pops an article off the stack' do
        machine = SaxMachine::StateMachine.new do |t|
          t << SaxMachine::Transition
            .new(SaxMachine::PushEvent.new(:article))
          t << SaxMachine::Transition
            .new(SaxMachine::PopEvent.new(:article))
        end
        machine.on_start_element(:article)
        machine.on_end_element(:article)
        expect(machine.stack.peek.name).to eq(:nil)
      end
    end
  end

  describe '#product' do
    it 'has no product, if there no transitions' do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article))
      end
      expect(machine.product).to be_nil
    end

    it 'returns an article' do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article))
        t << SaxMachine::Transition
          .new(SaxMachine::PopEvent.new(:article))
      end
      machine.on_start_element(:article)
      machine.on_end_element(:article)
      expect(machine.product.name).to eq(:article)
    end

    it 'returns an article with a front object component' do
      machine = SaxMachine::StateMachine.new do |t|
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:article))
        t << SaxMachine::Transition
          .new(SaxMachine::PushEvent.new(:front), :article)
        t << SaxMachine::Transition
          .new(SaxMachine::PopEvent.new(:front), :article)
        t << SaxMachine::Transition
          .new(SaxMachine::PopEvent.new(:article))
      end
      machine.on_start_element(:article)
      machine.on_start_element(:front)
      machine.on_end_element(:front)
      machine.on_end_element(:article)
      product = machine.product
      expect(product.name).to eq(:article)
      front = product.front
      expect(front.name).to eq(:front)
    end
  end
end
