class AddSizeAndLevelToQrCode < ActiveRecord::Migration
  def change
    add_column :qr_codes, :size, :integer
    add_column :qr_codes, :level, :string
  end
end
