class ProductionMailer < ActionMailer::Base
  default from: "artur@a4w.pl"

  def welcome_user (user)

    smtp_settings = {:port => 587,
      :domain               => "mail.a4w.pl",
      :user_name            => "artur",
      :password             => "",
      :authentication       => "plain",
      :enable_starttls_auto => true}

    @user = user
    @url = 'http://www.example.com/login'
  	mail(to: @user.email, subject: 'Witaj w serwisie RealizAfera!')
  end

end