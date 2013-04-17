class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def welcome_message(user)
    @user = user
    @site_url = root_url(only_path: false)
    subject = "Welcome to Campground"
    to_email = "#{user.name} <#{user.email}>"
    mail to: to_email, subject: subject
  end
end
