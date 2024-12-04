f = File.read("day_3_input.txt")

def setup(file)
  computer_code = []
  file.each_line.with_index do |line, index|
    computer_code[index] = line
  end

  return computer_code
end


instructions = setup(f)

def problem_1(instructions)
  total_mul_count = 0
  mul_list = []
  instructions.each do |instruction|
    mul_list << instruction.scan(/mul\(\d+,\d+\)/)
  end

  mul_list.each do |muls|
    muls.each do |mul|
      number = mul.scan(/\d+,\d+/).first.split(',').map(&:to_i)
      total_mul_count += number[0] * number[1]
    end
  end

  return total_mul_count
end

def problem_2(instructions)
  total_mul_count = 0
  command_list = []
  can_mul = true

  instructions.each_with_index do |instruction|
    command_list << instruction.scan(/(mul\(\d+,\d+\)|do\(\)|don't\(\))/).flatten
  end

  command_list.each do |commands|
    commands.each_with_index do |command, index|
      if command.match?(/mul\(\d+,\d+\)/)
        numbers = command.scan(/\d+,\d+/).first.split(',').map(&:to_i)
        commands[index] = numbers
      end
    end
  end

  command_list.flatten!(1)

  command_list.each do |command|
    case command
    when 'do()'
      can_mul = true
    when "don't()"
      can_mul = false
    else
      if can_mul && command[0].is_a?(Integer)
        total_mul_count += command[0] * command[1]
      end
    end
  end

  return total_mul_count
end

code_completion = problem_1(instructions)
p code_completion

code_completion_2 = problem_2(instructions)
p code_completion_2
