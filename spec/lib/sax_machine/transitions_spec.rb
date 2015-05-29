require 'sax_machine/transitions'
require 'sax_machine/transition'
require 'sax_machine/pop_event'
require 'sax_machine/push_event'
require 'sax_machine/text_event'

RSpec.describe SaxMachine::Transitions do
  describe '#size' do
    it 'has a single transition' do
      transitions = SaxMachine::Transitions.new do |t|
        t << SaxMachine::Transition.new(SaxMachine::PushEvent.new('article'))
      end
      expect(transitions.size).to eq(1)
    end

    it 'has two transitions' do
      transitions = SaxMachine::Transitions.new do |t|
        t << SaxMachine::Transition.new(SaxMachine::PushEvent.new('article'))
        t << SaxMachine::Transition.new(SaxMachine::PopEvent.new('article'))
      end
      expect(transitions.size).to eq(2)
    end
  end

  describe '#to_s' do
    it 'return a string representation of transitions' do
      transitions = SaxMachine::Transitions.new do |t|
        t << SaxMachine::Transition.new(SaxMachine::PushEvent.new('article'))
        t << SaxMachine::Transition.new(SaxMachine::PopEvent.new('article'))
        t << SaxMachine::Transition.new(SaxMachine::TextEvent.new('name'), 'article')
      end
      expect(transitions.to_s).to eq(
        '[ article : push ] (nil → article)/n'\
        '[ article : pop ] (nil ← article)/n'\
        '[ name : text ] (article)')
    end
  end
end
