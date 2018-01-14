class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    image = ""
    File.open(file).each do |line|
      line = line.chomp
      case line[0]
      when "I"
        image = ""
        m, n = line.match(/I ([0-9]+) ([0-9]+)/i).captures
        m = m.to_i
        n = n.to_i
        for i in 1..n
          image += "O"*m+"\n"
        end
      when "S"
        if image.length == 0
          puts "There is no image"
        else
          puts image
        end
      else
        puts 'unrecognised command :('
      end
    end
  end
end
