ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {  
	:address              => "smtp.outlook.com",  
	:port                 => 587,  
	:domain               => "outlook.com",  
	:user_name            => ENV['Email'],  
	:password             => ENV['PASSWORD'],  
	:authentication       => "plain",  
	:enable_starttls_auto => true  
}