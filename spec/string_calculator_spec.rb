require_relative './spec_helper.rb'

RSpec.describe StringCalculator do
  it 'return 0 for an empty string' do
    expect(StringCalculator.new('').add).to eq(0)
  end

  [['0', 0], ['1', 1], ['1000', 1000]].each do |input, expected|
    it "returns #{expected} for input '#{input}'" do
      expect(StringCalculator.new(input).add).to eq(expected)
    end
  end
end