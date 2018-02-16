class WelcomeController < ApplicationController
  def index
  end

  def send_mail
    CalendarMailer.send_mail.deliver
    flash[:notice] = "Email has been sent."
  end
end
