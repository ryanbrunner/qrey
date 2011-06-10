class QrCodesController < InheritedResources::Base
  actions :index, :new, :create, :show
  respond_to :html, :json, :xml, :png

  def create
    @qr_code = QrCode.initialize_for_type(params[:type], params[:qr_code])
    create!
  end

  def show
    show! do |format|
      format.png { send_data resource.to_png, :type => 'image/png', :disposition => 'inline' }
    end
  end
end