
def get_info(name)
  fileObj = File.new(name, "r")

  high_temp = 0
  low_temp = 0
  most_humid = 0

  count_high_temp = 0
  count_low_temp = 0
  count_most_humid = 0

  first_line_flag = false

  while (line = fileObj.gets)
    if first_line_flag ==false
      first_line_flag =true
    else
      data = line.split(",")

      if data[1] != ""
        count_high_temp = count_high_temp + 1
        high_temp = high_temp + data[1].to_i
      end

      if data[3] != ""
        count_low_temp = count_low_temp + 1
        low_temp = low_temp + data[3].to_i
      end

      if data[7] != ""
        count_most_humid = count_most_humid + 1
        most_humid = most_humid + data[7].to_i
      end
    end
  end
  fileObj.close

  avg_high_temp = high_temp/count_high_temp
  avg_low_temp = low_temp/count_low_temp
  avg_most_humid = most_humid/count_most_humid

  puts "Highest Average: #{avg_high_temp}C"
  puts "Lowest Average: #{avg_low_temp}C"
  puts "Average Humidity: #{avg_most_humid}%"
end

def main(year,month,folder_name)
  files_name = Dir.entries(folder_name)

  for item in files_name
    if item.include? year
      if item.include? month
        get_info("#{folder_name}/#{item}")
      end
    end
  end
end

if ARGV.length !=3
  puts "NO argument Enter Year, Month Name and Folder Name"
  return
end

year = ARGV[0]
month = ARGV[1]
folder_name = ARGV[2]

main(year,month,folder_name)
