class StringCalculator
  DEFAULT_DELIMITERS = /[,\n]/
  CUSTOM_DELIMITER_PREFIX = '//'

  # Constructor
  def initialize(str)
    @delimiters, @number_str = parse_delimiter(str)
    @numbers = parse_string
  end

  # Method to add the numbers
  # @return [Integer] The sum of the numbers
  def add
    @numbers.sum
  end

  private

  # Method to parse the string and extract numbers to be added
  # @return [Array<Integer>] An array of integers extracted from the string
  def parse_string
    return [] if @number_str.empty?
    nums = @number_str.split(@delimiters).map(&:to_i)
    negatives = nums.select { |n| n < 0 }

    raise "negatives not allowed: #{negatives.join(', ')}" unless negatives.empty?

    nums.reject { |n| n > 1000 }
  end

  # Method to parse the delimiter from the string
  # @param str [String] The string containing the delimiter
  # @return [Array<String, String>] An array containing the delimiter and the string without the delimiter
  def parse_delimiter(str)
    str.gsub!('\\n', "\n")

    if str.start_with?(CUSTOM_DELIMITER_PREFIX)
      delimiter_line, rest = str.split("\n", 2)
      rest ||= ""

      delimiter = delimiter_line[CUSTOM_DELIMITER_PREFIX.length..] || ""

      [Regexp.escape(delimiter), rest]
    else
      [DEFAULT_DELIMITERS, str]
    end
  end
end