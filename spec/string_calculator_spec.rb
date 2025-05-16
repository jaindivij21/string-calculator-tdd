require_relative './spec_helper.rb'

RSpec.describe StringCalculator do
  it 'return 0 for an empty string' do
    expect(StringCalculator.new('').add).to eq(0)
  end
end