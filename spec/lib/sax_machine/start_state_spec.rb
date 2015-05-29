require 'sax_machine/start_state'

RSpec.describe 'SaxMachine::StartState' do
  describe '#name' do
    it 'returns :nil' do
      start = SaxMachine::StartState.new
      expect(start.name).to eq(:nil)
    end
  end
end
