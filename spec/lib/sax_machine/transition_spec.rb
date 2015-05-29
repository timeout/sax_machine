require 'sax_machine/transition'
require 'sax_machine/push_event'
require 'sax_machine/text_event'
require 'sax_machine/pop_event'
require 'sax_machine/exceptions'

RSpec.describe SaxMachine::Transition do

  describe '#state_name' do
    it 'returns the name of the state_name' do
      transition = SaxMachine::Transition.new(SaxMachine::TextEvent
        .new(:surname), :name)
      expect(transition.state_name).to eq(:name)
    end

    it 'returns a :nil symbol as the default state_name' do
      transition = SaxMachine::Transition.new(SaxMachine::TextEvent
        .new(:surname))
      expect(transition.state_name).to eq(:nil)
    end

    it 'raises an exception if the state_name is nil' do
      expect{ SaxMachine::Transition.new(SaxMachine::PopEvent
        .new(:body), nil) }.to raise_error(SaxMachine::NilStateName)
    end
  end

  describe '#event_type' do
    it 'returns the event type of the transition' do
      transition = SaxMachine::Transition.new(SaxMachine::PushEvent
        .new('article'))
      expect(transition.event_type).to eq(:PushEvent)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of a PushEvent transition' do
      transition = SaxMachine::Transition.new(SaxMachine::PushEvent
        .new('article'))
      expect(transition.to_s).to eq('[ article : push ] (nil → article)')
    end

    it 'returns a string representation of a PopEvent transition' do
      transition = SaxMachine::Transition.new(SaxMachine::PopEvent
        .new('body'), 'article')
      expect(transition.to_s).to eq('[ body : pop ] (article ← body)')
    end

    it 'returns a string representation of a TextEvent transition' do
      transition = SaxMachine::Transition.new(SaxMachine::TextEvent
        .new('name'), 'author')
      expect(transition.to_s).to eq('[ name : text ] (author)')
    end
  end
end
