class Site::UserRequestsController < ApplicationController
  def create
    case params[:user_request]
    when "reset_password"
      @user = User.find_by_login_id(params[:user_login_id].downcase)
      if @user      
        user_request = Site::UserRequest.generate_new(@user.email, "password")
        user_email = UserMailer.reset_password_message(@user, user_request)
        success_message = "Email for resetting password sent"
      else
        flash[:error] = "Login ID not found"        
      end
    end
    
    if user_request && user_request.save 
      user_email.deliver
      flash[:success] = success_message
    else
      flash[:error] = "Email not sent. Try again."
    end

    redirect_to login_path          
    
  end

  def edit_request
    user_request = Site::UserRequest.find_by_token(params[:token])
    if user_request
      case user_request.request_type
      when "password"
        @user = User.find_by_email(user_request.email)
        render 'reset_password'
      end
    else
      redirect_to root_path
    end
  end

  def process_request
    user_request = Site::UserRequest.find_by_token(params[:token])
    if user_request
      case user_request.request_type
      when "password"
        @user = User.find_by_email(user_request.email)
        user_attributes = { password: params[:password], 
                            password_confirmation: params[:password_confirmation] }
        
        if @user.set_partial_attributes(user_attributes)
          log_in @user
          flash[:success] = "Password was reset."
          redirect_to root_path
        else
          render 'reset_password'
        end # resetting password
                
      end # different request types
    else # no user_request found
      redirect_to root_path
    end
  end
  

end
