f = File.read("day_2_input.txt")
def setup(file)
  reports = []
  file.each_line.with_index do |line, index|
    reports[index] = line.split().map(&:to_i)
  end

  return reports
end

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


reports = setup(f)

safe_reports = problem_1(reports)
puts "Safe reports: ", safe_reports
