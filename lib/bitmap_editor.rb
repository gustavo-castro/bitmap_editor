class BitmapEditor
  @@M = 0
  @@N = 0
  @@Image = ""
  attr_accessor :M, :N, :Image

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line[0]
      when "I"
        self.Image = ""
        n, m = line.match(/I ([0-9]+) ([0-9]+)/i).captures
        self.M = m.to_i
        self.N = n.to_i
        for i in 1..self.M
          self.Image += "O"*self.N+"\n"
        end
      when "L"
        x, y, c = line.match(/L ([0-9]+) ([0-9]+) ([A-Z])/i).captures
        x = x.to_i - 1
        y = y.to_i - 1
        if x < 0 || x >= self.N || y < 0 || y >= self.M
          raise "Can't color pixel outside of the image"
        end
        self.Image[y*(self.N+1)+x] = c #the +1 is for the \n character that skips the line when we show the image
      when "C"
        if line.length > 1
          raise "The clear command does not require any other input than the C character"
        end
        for i in 0..self.Image.length-1
          if self.Image[i] != "\n"
            self.Image[i] = "O"
          end
        end
      when "S"
        if self.Image.length == 0
          puts "There is no image"
        else
          puts self.Image
        end
      else
        puts 'unrecognised command :('
      end
    end
  end
end
