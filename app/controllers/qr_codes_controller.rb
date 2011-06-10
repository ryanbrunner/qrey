class QrCodesController < InheritedResources::Base
  actions :index, :new, :create, :show
  respond_to :html, :json, :xml, :png

  def create
    @qr_code = QrCode.initialize_for_type(params[:type], params[:qr_code])
    
    if @qr_code.save
      respond_to do |format|
        flash[:notice]= 'Successfully created QR code!'
        format.html { redirect_to @qr_code }
      end
    else
      respond_to do |format|
        logger.debug @qr_code.errors.messages.inspect
        flash[:error]= 'Something went wrong with your QR code generation.'
        format.html { render :action => :new }
      end
    end
    
  end

  def show
    show! do |format|
      format.png { send_data resource.to_png, :type => 'image/png', :disposition => 'inline' }
    end
  end
end
