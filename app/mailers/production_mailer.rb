class ProductionMailer < ActionMailer::Base
  default from: "no-reply@realizafera.pl"


  def welcome_user (user)
  	@user = user
  	@url = 'http://www.example.com/login'
  	mail(to: @user.email, subject: 'Witaj w serwisie RealizAfera!')
  end

end
