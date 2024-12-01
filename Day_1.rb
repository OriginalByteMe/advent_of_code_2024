f = File.read("day_1_input.txt")
# Part 1
########################################
list_1 = []
list_2 = []
count_distance = 0
f.each_line.with_index do |line, index|
  list_1[index] = line.split[0].to_i
  list_2[index] = line.split[1].to_i
end

list_1.sort!
list_2.sort!

list_1.each_with_index do |location, index|
  count_distance += (location - list_2[index]).abs
end

puts count_distance

#############################################

# Part 2
##############################################
similarity_score = 0

list_1_locations = list_1.uniq

list_1_locations.each do |unique_location|
  similarity_score += unique_location * list_2.count(unique_location) 
end
puts similarity_score

##############################################