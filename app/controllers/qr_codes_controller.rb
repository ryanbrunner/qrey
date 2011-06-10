class QrCodesController < InheritedResources::Base
  actions :index, :new, :create, :show
  respond_to :html, :json, :xml

  def create
    @qr_code = QrCode.initialize_for_type(params[:type], params[:qr_code])
    create!
  end
end