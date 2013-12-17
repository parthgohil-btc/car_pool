class Reminder < ActionMailer::Base
  default :from => "parth.gohil@beaverlogic.com"
  
  def car_pool_reminder(email)
    @email = email
    mail(:to => "<#{email}>", :subject => "Car pool reminder")
  end
end