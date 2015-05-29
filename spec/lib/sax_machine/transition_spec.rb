require 'sax_machine/transition'
require 'sax_machine/push_event'

RSpec.describe SaxMachine::Transition do
  describe '#event_type' do
    it 'returns the event type of the transition' do
      transition = SaxMachine::Transition.new(SaxMachine::PushEvent
        .new('article'), nil)
      expect(transition.event_type).to eq(:PushEvent)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of a PushEvent transition' do
      transition = SaxMachine::Transition.new(SaxMachine::PushEvent
        .new('article'), nil)
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
