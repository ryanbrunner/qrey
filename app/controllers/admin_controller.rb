class AdminController < ApplicationController
  inherit_resources
  
  http_basic_authenticate_with :name => ADMIN_CONFIG['user'], :password => ADMIN_CONFIG['pass']
  actions :index, :edit, :destroy
  respond_to :html, :json, :xml, :png
  # before_filter :qr_code
  
  def index
    @qr_codes = QrCode.order("created_at DESC").all
  end
  
  # def qr_code
  #   @qr_code = QrCode.find(params[:id])
  # end
  
end
