require 'date'

def get_date(data)
  Date.strptime(data, '%Y-%m-%d').strftime("%b %d")
end

def get_info(name,high_temp_hash,low_temp_hash,most_humid_hash)
  fileObj = File.new(name, "r")

  high_temp = 0
  low_temp = 999
  most_humid = 0

  high_temp_date = ""
  low_temp_date = ""
  most_humid_date = ""


  first_line_flag = false

  while (line = fileObj.gets)
    if first_line_flag ==false
      first_line_flag =true
    elsif
      data = line.split(",")

      if data[1].to_i > high_temp && data[1] != ""
        high_temp = data[1].to_i
        high_temp_date = get_date(data[0])
      end

      if data[3].to_i < low_temp && data[3] != ""
        low_temp = data[3].to_i
        low_temp_date = get_date(data[0])
      end

      if data[7].to_i > most_humid && data[7] != ""
        most_humid = data[7].to_i
        most_humid_date = get_date(data[0])
      end

    end
  end
  fileObj.close


  high_temp_hash.store(high_temp_date,high_temp)
  low_temp_hash.store(low_temp_date,low_temp)
  most_humid_hash.store(most_humid_date,most_humid)

end

def main(year,folder_name)
  files_name = Dir.entries(folder_name)

  high_temp_hash = Hash[]
  low_temp_hash = Hash[]
  most_humid_hash = Hash[]

  for item in files_name
    if item.include? year
    get_info("#{folder_name}/#{item}",high_temp_hash,low_temp_hash,most_humid_hash)
    end
  end

  a = high_temp_hash.key(high_temp_hash.values.max)
  b = low_temp_hash.key(low_temp_hash.values.min)
  c = most_humid_hash.key(most_humid_hash.values.max)

  puts "Highest: #{high_temp_hash[a]}C on #{a}"
  puts "Lowest: #{low_temp_hash[b]}C on #{b}"
  puts "Humid: #{most_humid_hash[c]}% on #{c}"
end

if ARGV.length !=2
  puts "NO argument Enter Year and Folder Name"
  return
end

year = ARGV[0]
folder_name = ARGV[1]

main(year,folder_name)
