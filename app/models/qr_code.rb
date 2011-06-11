class QrCode < ActiveRecord::Base
  attr_accessible :data, :size, :level

  validates :data, :size, :level, :presence => true

  validate :validates_length_of_data

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
    code = QRCodeImage.new( self.data, self.size, self.level.downcase.to_sym )
    code.as_png
  end

  def to_qr_code
    RQRCode::QRCode.new( self.data, :size => self.size, :level => self.level.downcase.to_sym )
  end

  protected
  
  def validates_length_of_data

    case self.size
      when 1
         min = 10
         max = 25
      when 2
        min = 20
        max = 47
      when 3
        min = 35
        max = 77
      when 4
        min = 67
        max = 114
      when 10
        min = 174
        max = 395
      when 40
        min = 1852
        max = 4296
    end

    errors[:data] = "can't be more than #{max} characters long." if self.data.size.to_i > max
  end
  
end
