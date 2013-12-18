ActionMailer::Base.smtp_settings = { 
   :address              => "smtp.live.com",
   :port                 => 587,
   :enable_starttls_auto => true,
   :user_name            => ENV['EMAIL'],  
   :password             => ENV['PASSWORD'],
   :domain               => 'outlook.com',
   :authentication       => 'plain'
 }