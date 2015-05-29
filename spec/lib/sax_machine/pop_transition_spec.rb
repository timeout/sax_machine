require 'sax_machine/pop_event'

RSpec.describe SaxMachine::PopEvent do
  describe '#event' do
    it 'returns the event' do
      transaction = SaxMachine::PopEvent.new('article')
      expect(transaction.event).to eq('article')
    end
  end

  describe '#eql?(other)' do
    it 'is true' do
      transaction = SaxMachine::PopEvent.new('article')
      expect(transaction.eql? SaxMachine::PopEvent.new('article'))
        .to be_truthy
    end
  end

  describe '==(other)' do
    it 'is true' do
      transaction = SaxMachine::PopEvent.new('article')
      expect(transaction == SaxMachine::PopEvent.new('article'))
        .to be_truthy
    end
  end
end
