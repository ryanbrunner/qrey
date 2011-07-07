# Simple class to construct QR images and return them as scaled PNG
# image data.
# 
# Useful information can be found at:
# * http://en.wikipedia.org/wiki/QR_Code
# * http://www.qrcode.com/index-e.html
class QRCodeImage
  require 'rqrcode'
  require 'RMagick'

  # Creates a new QRCodeImage object.
  #
  # +string+:: the data to be encoded
  # +version+:: the version of the QR code (1 .. 40)
  # +level+:: ecc level (:l, :m, :q, :h)
  def initialize(string, version, level)
    @qr = RQRCode::QRCode.new(string, :size => version, :level => level)
  end

  # Returns the QR code as a blob of PNG data.
  #
  # +scale+:: the number of pixels wide & deep to render each QR Code module
  def as_png(scale=5)
    pixels = @qr.modules.size

    img = Magick::Image.new(pixels, pixels)
    img.format = 'PNG'
    img.background_color = 'white'

    pixels.times do |x|
      pixels.times do |y|
        if @qr.dark?(y,x)
          img.pixel_color(x, y, 'black')
        end
      end
    end

    img.scale(scale).to_blob
  end
end
