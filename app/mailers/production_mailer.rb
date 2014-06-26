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


  def remind_about_productions (production)
    # TODO
  end


  def incoming_productions_reminder
    # This method is regularly called by cron

    Production.all.each do |p|
      # For each comming production
      dayDiff = (p.start_day + 7 - Time.now.wday) % 7
      hourDiff = 24 * dayDiff + p.start_hour - Time.now.hour

      # If production is close (at most 30h) and wasn't reminded yet then remind about it
      if hourDiff < 30 && p.reminded == false
        msg = ProductionMailer.remind_about_productions(p)
        msg.deliver

        p.reminded = true
        p.save
      end
    end
  end

  def weekly_reminder
    # This method is regularly called by cron
    Production.all.each do |p|
      # TODO
    end
  end

end