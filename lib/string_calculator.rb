class StringCalculator
  # Constructor
  def initialize(str)
    @numbers = parse_string(str)
  end

  # Method to add the numbers
  # @return [Integer] The sum of the numbers
  def add
    @numbers.sum
  end

  private

  # Method to parse the string and extract numbers to be added
  # @param str [String] The string containing numbers to be added
  # @return [Array<Integer>] An array of integers extracted from the string
  def parse_string(str)
    return [] if str.empty?

    str.split(',').map(&:to_i)
  end
end