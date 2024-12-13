f = File.read("day_5_input.txt")

def setup(file)
  temp_data = []
  ordering_rules = []
  page_data = []


  file.each_line.with_index do |line, index|
    temp_data[index] = line.chomp
  end
  # p temp_data
  split_point = temp_data.find_index("")
  ordering_rules = temp_data.take(split_point).map do |rule|
    rule.split("|").map(&:to_i)
  end
  page_data = temp_data.drop(split_point + 1).map do |line|
    line.strip             # Remove whitespace
        .split(',')            # Split on remaining whitespace
        .map(&:to_i)      # Convert each element to integer
  end
  return ordering_rules, page_data
end

ordering_rules, page_data = setup(f)
p page_data.length

def get_relevant_rulesets(ordering_rules, data)
  rule_hash = {}

  ordering_rules.each do |pair|
    first, second = pair
    # If both numbers exist in data
    if data.include?(first) && data.include?(second)
      if rule_hash.key?(first)
        # Append to existing array if key exists
        rule_hash[first] << second
      else
        # Create new array with second number if key is new
        rule_hash[first] = [second]
      end
    end
  end

  return rule_hash
end

def is_valid_sequence?(data, rules_left)
  seen_numbers = []
  data.each do |number|
    # Check if current number violates any rules with previously seen numbers
    rules_left.each do |first, seconds|
      if seconds.include?(number) && !seen_numbers.include?(first)
        # Found a violation - trying to use second before first
        return false
      end
    end
    seen_numbers << number
  end
  true
end

def problem_1(ordering_rules, page_data)
  valid_data_count = 0

  page_data.each_with_index do |data, index|
    rules_left = get_relevant_rulesets(ordering_rules, data)

    if is_valid_sequence?(data, rules_left)
      middle_index = data.length / 2
      valid_data_count += data[middle_index]
      puts "Valid sequence #{index}: #{data.inspect}, middle: #{data[middle_index]}"
    else
      puts "Invalid sequence #{index}: #{data.inspect}"
    end
  end
  valid_data_count
end

valid_data_count = problem_1(ordering_rules, page_data)
p valid_data_count
