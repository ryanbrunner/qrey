class QrCodesController < InheritedResources::Base
  actions :index, :new, :create, :show
  respond_to :html, :json, :xml
end