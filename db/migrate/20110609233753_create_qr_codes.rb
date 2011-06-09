class CreateQrCodes < ActiveRecord::Migration
  def change
    create_table :qr_codes do |t|
      t.text :data

      t.timestamps
    end
  end
end
