class QrCode < ActiveRecord::Base
  validates :data, :presence => true

  LEVEL = :h
  SIZE = 4

  def to_qr_code
    RQRCode::QRCode.new( self.data, :size => SIZE, :level => LEVEL )
  end
end
