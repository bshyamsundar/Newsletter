class CalendarMailer < ApplicationMailer

  add_template_helper(WelcomeHelper) 
  
  def send_mail
    mail(to: 'bananatroughtest@gmail.com', from: 'bananatroughtest@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
