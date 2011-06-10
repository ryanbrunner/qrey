# Simple class to construct QR images and return them as scaled PNG
# image data.

require 'rqrcode'
require 'rmagick'

class QRCodeImage

  LEGAL_SIZES = [1, 2, 3, 4, 10, 40]
  LEGAL_LEVELS = [:l, :m, :q, :h]

  def initialize(string, size, level)
    @qr = RQRCode::QRCode.new(string, :size => size, :level => level)
  end

  # returns the QR code as a PNG with each pixel scaled to scale x scale
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
