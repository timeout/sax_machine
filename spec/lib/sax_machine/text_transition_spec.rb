require 'sax_machine/text_event'

RSpec.describe SaxMachine::TextEvent do
  describe '#event' do
    it 'returns the event' do
      transaction = SaxMachine::TextEvent.new('article')
      expect(transaction.event).to eq('article')
    end
  end

  describe '#eql?(other)' do
    it 'is true' do
      transaction = SaxMachine::TextEvent.new('article')
      expect(transaction.eql? SaxMachine::TextEvent.new('article'))
        .to be_truthy
    end
  end

  describe '==(other)' do
    it 'is true' do
      transaction = SaxMachine::TextEvent.new('article')
      expect(transaction == SaxMachine::TextEvent.new('article'))
        .to be_truthy
    end
  end
end
