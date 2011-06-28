class ApplicationController < ActionController::Base
  protect_from_forgery

  ADMIN_CONFIG = YAML::load_file(File.join(Rails.root, 'config', 'admin.yml'))
end
