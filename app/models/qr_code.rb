class QrCode < ActiveRecord::Base
  validates :data, :presence => true
end
