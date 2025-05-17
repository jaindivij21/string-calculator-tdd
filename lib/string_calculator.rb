class StringCalculator
  DEFAULT_DELIMITERS = /[,\n]/
  CUSTOM_DELIMITER_PREFIX = '//'
  CUSTOM_DELIMITER_PATTERN = /\[(.*?)\]/

  # Constructor
  def initialize(input)
    @delimiters, @numbers_string = extract_delimiters_and_numbers(input)
  end

  # Method to add the numbers
  # @return [Integer] The sum of the numbers
  def add
    numbers = parse_numbers
    validate_no_negatives(numbers)
    numbers.reject { |n| n > 1000 }.sum
  end

  private

  # Method to extract delimiters and the number string from the input string
  # @param input [String] The input string
  # @return [Array<Regexp, String>] The delimiters and the numbers string
  def extract_delimiters_and_numbers(input)
    input = input.gsub('\\n', "\n")

    if input.start_with?(CUSTOM_DELIMITER_PREFIX)
      delimiter_line, numbers_string = input.split("\n", 2)
      numbers_string ||= ""
      delimiter = create_delimiter_from(delimiter_line[CUSTOM_DELIMITER_PREFIX.size..])
      [delimiter, numbers_string]
    else
      [DEFAULT_DELIMITERS, input]
    end
  end

  # Method to create a Regexp from the delimiter part
  # @param delimiter_part [String, nil] The part of the string that contains the delimiters
  # @return [Regexp] The Regexp object representing the delimiters
  def create_delimiter_from(delimiter_part)
    if delimiter_part&.start_with?('[') && delimiter_part&.end_with?(']')
      delimiters = delimiter_part.scan(CUSTOM_DELIMITER_PATTERN).flatten
      Regexp.new(delimiters.map { |d| Regexp.escape(d) }.join('|'))
    else
      Regexp.new(Regexp.escape(delimiter_part || ""))
    end
  end

  # Method to parse the numbers from the numbers string
  # @return [Array<Integer>] The parsed numbers
  def parse_numbers
    return [] if @numbers_string.to_s.empty?
    @numbers_string.split(@delimiters).map(&:to_i)
  end

  # Method to validate that there are no negative numbers
  # @param numbers [Array<Integer>] The array of numbers to validate
  # @raise [RuntimeError] If there are negative numbers
  # @return [void]
  def validate_no_negatives(numbers)
    negatives = numbers.select { |n| n < 0 }
    raise "negatives not allowed: #{negatives.join(', ')}" unless negatives.empty?
  end
end