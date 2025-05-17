require_relative './spec_helper.rb'

RSpec.describe StringCalculator do
  describe '#add' do
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

    [['1,-2', 'negatives not allowed: -2'], ["//;\n1;-2", 'negatives not allowed: -2']].each do |input, expected|
      it "raises an exception for input '#{input}' with negative numbers" do
        expect { StringCalculator.new(input).add }.to raise_error(RuntimeError, expected)
      end
    end

    [['1003, 2', 2]].each do |input, expected|
      it "return #{expected} for input '#{input}' ignoring numbers greater than 1000" do
        expect(StringCalculator.new(input).add).to eq(expected)
      end
    end

    [["//[***]\n1***2***3", 6]].each do |input, expected|
      it "return #{expected} for input '#{input}' supporting multi-character delimiters" do
        expect(StringCalculator.new(input).add).to eq(expected)
      end
    end

    [["//[***][%%%]\n1***2%%%3", 6], ["//[*][%]\n1*2%5", 8]].each do |input, expected|
      it "return #{expected} for input '#{input}' supporting multiple multi-character delimiters" do
        expect(StringCalculator.new(input).add).to eq(expected)
      end
    end
  end
end