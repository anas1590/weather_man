require 'date'
require 'colorize'

def get_info(name)
  fileObj = File.new(name, "r")


  first_line_flag = false

  while (line = fileObj.gets)
    if first_line_flag ==false
      first_line_flag =true
    else
      data = line.split(",")

      if data[1] != "" && data[3] != ""
        print "#{Date.strptime(data[0], '%Y-%m-%d').strftime("%d")} "
        for a in 1..data[3].to_i do
          print '+'.blue
         end
        for a in 1..data[1].to_i do
          print '+'.red
         end
         print " #{data[3].to_i}C -  #{data[1].to_i}C\n"
      end


    end
  end
  fileObj.close

end

def main(year,month,folder_name)
  files_name = Dir.entries(folder_name)
  month_name = Date.strptime(month.to_s, '%m').strftime("%b")

  for item in files_name
    if item.include? year
      if item.include? month_name
        get_info("#{folder_name}/#{item}")
      end
    end
  end
end

if ARGV.length !=3
  puts "NO argument Enter Year, Month Number and Folder Name"
  return
end

year = ARGV[0]
month = ARGV[1]
folder_name = ARGV[2]

main(year,month,folder_name)
