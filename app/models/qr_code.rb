class QrCode < ActiveRecord::Base
  attr_accessible :data, :size, :level

  validates :data, :size, :level, :presence => true

#  LEVEL = :h
#  SIZE = 4

  def self.initialize_for_type(type, params)
    code = new(params)
    case type
      when 'text'
        code.data
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
    code = QRCodeImage.new( self.data, self.size, self.level.level.downcase.to_sym )
    code.as_png
  end

  def to_qr_code
    RQRCode::QRCode.new( self.data, :size => self.size, :level => self.level.downcase.to_sym )
  end

end
