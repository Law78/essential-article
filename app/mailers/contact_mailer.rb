
class ContactMailer < ActionMailer::Base
  default to: "postaforum@gmail.com"
  
  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message

  
  mail(from: email, subject: "Lorenzo's Articles Contact Form Message")
  end
end