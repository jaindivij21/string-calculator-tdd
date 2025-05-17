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
  # @return [Array<(Regexp, String)>] An array containing the delimiter regexp and the remaining string
  def parse_delimiter(str)
    str = str.gsub('\\n', "\n")

    if str.start_with?(CUSTOM_DELIMITER_PREFIX)
      delimiter_line, rest = str.split("\n", 2)
      rest ||= ""

      delimiter_part = delimiter_line[CUSTOM_DELIMITER_PREFIX.size..]
      delimiter_part ||= ""

      if delimiter_part&.start_with?('[') && delimiter_part&.end_with?(']')
        delimiters = delimiter_part.scan(/\[(.*?)\]/).flatten
        delimiter_regexp = Regexp.new(delimiters.map { |d| Regexp.escape(d) }.join('|'))

        [delimiter_regexp, rest]
      else
        [Regexp.new(Regexp.escape(delimiter_part)), rest]
      end
    else
      [DEFAULT_DELIMITERS, str]
    end
  end
end