require 'rqrcode'
require 'rmagick'

class QRCodeImage
  def initialize(string, size, level)
    @qr = RQRCode::QRCode.new(string, size, level)
  end

  def as_png(scale=5)
    pixels = @qr.modules.size

    img = Magick::Image.new(pixels, pixels)
    img.format = 'PNG'
    img.background_color = 'white'

    @qr.modules.each_with_index do |row, y|
      row.each_with_index do |dark, x|
        img.pixel_color(x, y, 'black') if dark
      end
    end

    img.scale!(scale)           

    img.to_blob
  end
end
