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

total_code = problem_1(instructions)
p total_code
