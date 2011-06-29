class QrCodesController < ApplicationController
  inherit_resources
  
  http_basic_authenticate_with :name => ADMIN_CONFIG['user'], 
                               :password => ADMIN_CONFIG['pass'], 
                               :only => [:edit, :update, :destroy]
                               
  actions :index, :new, :create, :show, :edit, :destroy
  respond_to :html, :json, :xml, :png

  def index
    @qr_code = QrCode.offset(rand(Thing.count)).first
  end

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
      format.png { send_file resource.to_png, :type => 'image/png', :disposition => 'attachment' }
    end
  end
  
  def update
    if resource.update_attributes params[:qr_code]
      respond_to do |format|
        flash[:notice] = "Successfully updated."
        format.html { redirect_to :controller => :admin, :action => :index }
      end
    else
      respond_to do |format|
        logger.debug @qr_code.errors.messages.inspect
        flash[:error] = "An error occurred when trying to update."
        format.html { render :edit }
      end
    end
  end
  
  def destroy
    if resource.destroy
      respond_to do |format|
        flash[:notice] = 'Successdully deleted entry.'
        format.html { redirect_to :controller => :admin, :action => :index }
      end
    else
      respond_to do |format|
        logger.debug @qr_code.errors.messages.inspect
        flash[:error] = 'An error occurred when trying to delete entry.'
        format.html { redirect_to :controller => :admin, :action => :index }
      end
    end
  end
  
end
