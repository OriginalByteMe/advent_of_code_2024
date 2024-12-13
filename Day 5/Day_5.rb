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

def is_valid_sequence?(data, dataset_rules)
  seen_numbers = []
  data.each do |number|
    # Check if current number violates any rules with previously seen numbers
    dataset_rules.each do |first, seconds|
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
    dataset_rules = get_relevant_rulesets(ordering_rules, data)

    if is_valid_sequence?(data, dataset_rules)
      middle_index = data.length / 2
      valid_data_count += data[middle_index]
      # puts "Valid sequence #{index}: #{data.inspect}, middle: #{data[middle_index]}"
    else
      # puts "Invalid sequence #{index}: #{data.inspect}"
    end
  end
  valid_data_count
end

def sort_to_correct_order(rules, data)
  # Using topologic sort
  # Creates a graph of dependencies
  # Another hash of the number of dependencies a number should have before it
  # After building these two hashes, create a queue starting with the number which has no dependencies (graph should always start at 0)
  # Add that first number to the result array (as its garunteed to be first)
  # Loop through each graph dependency, go through as many degree's it has and add them to the queue
  # Queue will shift the array and add it to result, in the end the result will be sorted according to the ruleset set

  # Step 1: Setup
  graph = {}           # Who must come before who
  in_degree = {}       # How many things must come before each number

  # Step 2: Build relationships
  data.each { |n| graph[n] = [] }     # Initialize each number
  rules.each do |first, seconds|
    seconds.each do |second|
      if data.include?(first) && data.include?(second)
        graph[first] << second         # first must come before second
        in_degree[second] ||= 0
        in_degree[second] += 1         # second has one more dependency
      end
    end
  end

  # Step 3: Find starting points (no dependencies)
  queue = data.select { |n| !in_degree[n] }

  # Step 4: Build sorted order
  result = []
  while !queue.empty?
    current = queue.shift             # Take next available number
    result << current                 # Add to result

    # Remove this dependency from others
    graph[current].each do |next_num|
      in_degree[next_num] -= 1
      queue << next_num if in_degree[next_num] == 0
    end
  end

  result
end

def problem_2(ordering_rules, page_data)
  corrected_data_count = 0

  page_data.each_with_index do |data, index|
    dataset_rules = get_relevant_rulesets(ordering_rules, data)

    if !is_valid_sequence?(data, dataset_rules)
      corrected_data = sort_to_correct_order(dataset_rules, data)
      middle_index = corrected_data.length / 2
      corrected_data_count += corrected_data[middle_index]
      # puts "Valid sequence #{index}: #{data.inspect}, middle: #{data[middle_index]}"
    else
      # puts "Invalid sequence #{index}: #{data.inspect}"
    end
  end
  corrected_data_count

end



valid_data_count = problem_1(ordering_rules, page_data)
p valid_data_count

corrected_data_count = problem_2(ordering_rules, page_data)
p corrected_data_count
