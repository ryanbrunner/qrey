class QrCode < ActiveRecord::Base
  validates :data, :presence => true

  LEVEL = :h
  SIZE = 4

  def self.initialize_for_type(type, params)
    code = new(params)
    case type
    when 'tel'
      code.data = "tel:#{code.data}"
    when 'email'
      code.data = "mailto:#{code.data}"
    when 'url'
      code.data = "http://#{code.data}" unless code.data.starts_with? 'http://'
    when 'sms'
      code.data = "sms:#{code.data}"
    end
    code
  end

  def to_png
    require 'qr_code_image'
    code = QRCodeImage.new( self.data, SIZE, LEVEL )
    code.as_png
  end

  def to_qr_code
    RQRCode::QRCode.new( self.data, :size => SIZE, :level => LEVEL )
  end
end
