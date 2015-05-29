require 'sax_machine/push_event'

RSpec.describe SaxMachine::PushEvent do
  describe '#event' do
    it 'returns the event' do
      transaction = SaxMachine::PushEvent.new('article')
      expect(transaction.event).to eq('article')
    end

    it 'returns the event' do
      transaction = SaxMachine::PushEvent.new(:article)
      expect(transaction.event).to eq(:article)
    end
  end

  describe '#eql?(other)' do
    it 'is true' do
      transaction = SaxMachine::PushEvent.new('article')
      expect(transaction.eql? SaxMachine::PushEvent.new('article'))
        .to be_truthy
    end
  end

  describe '==(other)' do
    it 'is true' do
      transaction = SaxMachine::PushEvent.new('article')
      expect(transaction == SaxMachine::PushEvent.new('article'))
        .to be_truthy
    end
  end
end
