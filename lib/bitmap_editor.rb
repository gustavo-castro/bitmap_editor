class BitmapEditor
  @@M = 0
  @@N = 0
  attr_accessor :M, :N

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    image = ""
    File.open(file).each do |line|
      line = line.chomp
      case line[0]
      when "I"
        image = ""
        n, m = line.match(/I ([0-9]+) ([0-9]+)/i).captures
        self.M = m.to_i
        self.N = n.to_i
        for i in 1..self.M
          image += "O"*self.N+"\n"
        end
      when "L"
        x, y, c = line.match(/L ([0-9]+) ([0-9]+) ([A-Z])/i).captures
        x = x.to_i - 1
        y = y.to_i - 1
        if x < 0 || x >= self.N || y < 0 || y >= self.M
          raise "Can't color pixel outside of the image"
        end
        image[y*(self.N+1)+x] = c
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
