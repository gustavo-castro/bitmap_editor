class BitmapEditor
  @@M = 0
  @@N = 0
  @@Image = ""
  attr_accessor :M, :N, :Image

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      first_letter = line[0]
      case first_letter
      when "I"
        initiate_image(line)
      when "L"
        color_pixel(line)
      when "C"
        clear_image(line)
      when "H"
        color_row(line)
      when "V"
        color_column(line)
      when "S"
        show_image(line)
      else
        puts 'unrecognised command :('
      end
    end
  end

  def initiate_image(line)
    self.Image = ""
    regex_match = line.match(/^I ([0-9]+) ([0-9]+)$/i)
    if regex_match.nil?
      raise "Incorrect use of the I command"
    end
    n, m = regex_match.captures
    self.N = n.to_i
    self.M = m.to_i
    if self.N < 1 || self.N > 250 || self.M < 1 || self.N > 250
      raise "Matrix should have at least 1 column and row and at most 250 columns or rows"
    end
    for i in 1..self.M
      self.Image += "O"*self.N+"\n"
    end
  end

  def color_pixel(line)
    regex_match = line.match(/^L ([0-9]+) ([0-9]+) ([A-Z])$/i)
    if regex_match.nil?
      raise "Incorrect use of the L command"
    end
    x, y, c = regex_match.captures
    x = x.to_i - 1
    y = y.to_i - 1
    if x < 0 || x >= self.N || y < 0 || y >= self.M
      raise "Can't color pixel outside of the image"
    end
    self.Image[y*(self.N+1)+x] = c #the +1 is for the \n character that skips the line when we show the image
  end

  def clear_image(line)
    if line.length > 1
      raise "Incorrect use of the C command"
    end
    for i in 0..self.Image.length-1
      if self.Image[i] != "\n"
        self.Image[i] = "O"
      end
    end
  end

  def color_row(line)
    regex_match = line.match(/^H ([0-9]+) ([0-9]+) ([0-9]+) ([A-Z])$/i)
    if regex_match.nil?
      raise "Incorrect use of the H command"
    end
    x1, x2, y, c = regex_match.captures
    x1 = x1.to_i - 1
    x2 = x2.to_i - 1
    y = y.to_i - 1
    if x1 < 0 || x1 > x2 || x2 >= self.N || y < 0 || y >= self.M
      raise "Can't color pixel outside of the image"
    end
    for pixel in y*(self.N+1)+x1..y*(self.N+1)+x2
      self.Image[pixel] = c
    end
  end

  def color_column(line)
    regex_match = line.match(/^V ([0-9]+) ([0-9]+) ([0-9]+) ([A-Z])$/i)
    if regex_match.nil?
      raise "Incorrect use of the V command"
    end
    x, y1, y2, c = regex_match.captures
    x = x.to_i - 1
    y1 = y1.to_i - 1
    y2 = y2.to_i - 1
    if x < 0 || x >= self.N || y1 < 0 || y1 > y2 || y2 >= self.M
      raise "Can't color pixel outside of the image"
    end
    (x+y1*(self.N+1)..x+y2*(self.N+1)).step(self.N+1).each do |pixel|
      self.Image[pixel] = c
    end
  end

  def show_image(line)
    if line.length > 1
      raise "Incorrect use of the S command"
    end
    if self.Image.length == 0
      puts "There is no image"
    else
      puts self.Image
    end
  end
end
