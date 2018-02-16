class CalendarMailer < ApplicationMailer

  add_template_helper(WelcomeHelper) 
  
  def send_mail
    @url  = 'http://example.com/login'
    mail(to: 'straker@carryer.com', subject: 'Welcome to My Awesome Site')
  end
end
