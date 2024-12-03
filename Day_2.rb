f = File.read("day_2_input.txt")

def setup(file)
  reports = []
  file.each_line.with_index do |line, index|
    reports[index] = line.split().map(&:to_i)
  end

  return reports
end

reports = setup(f)

## My solution to problem 1

def problem_1(reports)
  safe_report_num = 0
  reports.each do |report|
    is_decreasing = false
    is_increasing = false
    valid_report = true
    report[0...-1].each_with_index do |number, index|
      number_difference = (report[index] - report[index + 1]).abs

      if is_decreasing && report[index] > report[index + 1]
        valid_report = false
        break
      end

      if is_increasing && report[index] < report[index + 1]
        valid_report = false
        break
      end

      if report[index] > report[index + 1]
        is_increasing = true
      end

      if report[index] < report[index + 1]
        is_decreasing = true
      end

      if number_difference > 3 || number_difference < 1
        valid_report = false
        break
      end
    end

    if valid_report
      safe_report_num += 1
    end
  end

  return safe_report_num
end

safe_reports = problem_1(reports)
puts "Safe reports: ", safe_reports

## My solution to problem 2

def number_tolerance(array)
  array[0...-1].each_with_index do |num, index|
    number_difference = (array[index] - array[index + 1]).abs
    if number_difference > 3 || number_difference < 1
      return false
    end
  end
  true
end

def is_sorted(array)
  return false if !array.each_cons(2).all? { |a, b| a >= b } && !array.each_cons(2).all? { |a, b| a <= b }
  return true
end

def is_report_safe(report)
  if !is_sorted(report) || !number_tolerance(report)
    return false
  end
  true
end

def problem_2(reports)
  correct_count = 0
  report_possibilities = []

  # Create possibilities for each report
  reports.each do |report|
    possibilities = []
    possibilities << report.dup
    report.each_with_index do |number, index|
      temp_report = report.dup
      temp_report.delete_at(index)
      possibilities << temp_report
    end
    report_possibilities << possibilities
  end

  report_possibilities.each do |possibilities|
    if possibilities.any? { |possibility| is_report_safe(possibility) }
      correct_count += 1
    end
  end

  correct_count
end



safe_reports_with_exception = problem_2(reports)
puts "Safe reports with exception: ", safe_reports_with_exception
