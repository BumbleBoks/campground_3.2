class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def invite_message(request)
    @invite_url = edit_site_user_request_url(request.token, only_path: false)
    subject = "Campground Invitation"
    to_email = request.email
    mail to: to_email, subject: subject    
  end

  def welcome_message(user)
    @user = user
    @site_url = root_url(only_path: false)
    subject = "Welcome to Campground"
    to_email = "#{user.name} <#{user.email}>"
    mail to: to_email, subject: subject
  end
  
  def reset_password_message(user, request)
    @user = user
    @reset_url = edit_site_user_request_url(request.token, only_path: false)
    subject = "Your Campground Account"
    to_email = "#{@user.name} <#{@user.email}>"
    mail to: to_email, subject: subject
  end
end
