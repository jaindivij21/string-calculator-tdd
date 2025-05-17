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

  [['0  ', 0], ['   1', 1], [' 1000   ', 1000]].each do |input, expected|
    it "returns #{expected} for input '#{input}' with spaces" do
      expect(StringCalculator.new(input).add).to eq(expected)
    end
  end

  [['1,2', 3], ['1,2,3', 6], ['1,2,3,4', 10]].each do |input, expected|
    it "returns #{expected} for input '#{input}' with commas as default delimiter" do
      expect(StringCalculator.new(input).add).to eq(expected)
    end
  end

  [['1,2  ', 3], ['  1,2,3', 6], ['    1,2,3,4  ', 10]].each do |input, expected|
    it "returns #{expected} for input '#{input}' with commas as default delimiter and spaces" do
      expect(StringCalculator.new(input).add).to eq(expected)
    end
  end

  [['1\n2,3', 6], ['1\n2,3\n4', 10], ["1,\n", 1], ["1,\n,,, 2", 3]].each do |input, expected|
    it "returns #{expected} for input '#{input}' with newlines as delimiters" do
      expect(StringCalculator.new(input).add).to eq(expected)
    end
  end

  [["//;\n1;2", 3], ["//;\n", 0]].each do |input, expected|
    it "return #{expected} for input '#{input}' with custom delimiter" do
      expect(StringCalculator.new(input).add).to eq(expected)
    end
  end
end