
ActionMailer::Base.smtp_settings = {
	:address				=>	"smtp.mailgun.org",
	:port                   =>  587,
	:authentication         =>  :plain,
	:enable_starttls_auto   =>	true 
}
	 
