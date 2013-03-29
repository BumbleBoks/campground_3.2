class SessionsController < ApplicationController
  # on upgrading to rails 4 encrypt cookies using
  # # config/initializers/session_store.rb
  # Myapp::Application.config.session_store :upgrade_signature_to_encryption_cookie_store, key: 'existing session key'
  # 
  # # config/initializers/secret_token.rb
  # Myapp::Application.config.secret_token = 'existing secret token'
  # Myapp::Application.config.secret_key_base = 'new secret key base'

  def new    
  end
  
  def create
    user = User.find_by_login_id(params[:login_id].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to(root_path)
    else
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to(root_path, :notice => "Logged out!")
  end
end
