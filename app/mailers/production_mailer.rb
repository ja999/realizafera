class ProductionMailer < ActionMailer::Base
  default from: "artur@a4w.pl"

  def welcome_user user

    smtp_settings = {
      port: 587,
      domain:               "mail.a4w.pl",
      user_name:            "artur",
      password:             "",
      authentication:       "plain",
      enable_starttls_auto: true,
    }

    @user = user
    @url = 'http://www.example.com/login'
  	mail(to: @user.email, subject: 'Witaj w serwisie RealizAfera!')
  end

  def productions_reminder user, productions
    @user = user.decorate
    @productions = productions.decorate
    @url = "#{request.domain}/my_productions"

    smtp_settings = {
      port: 587,
      domain:               "mail.a4w.pl",
      user_name:            "artur",
      password:             "",
      authentication:       "plain",
      enable_starttls_auto: true,
    }

    mail(to: @user.email, subject: 'RealizAfera - przypomnienie o realizacjach! Ku chwale Afery!')
  end

  def send_productions_reminder
    # This method is regularly called by cron
    Production.assigned.group_by(&:user).each do |user, productions|
      productions.each do |p|
        user_productions = []
        dayDiff = (p.start_day + 7 - Time.now.wday) % 7
        hourDiff = 24 * dayDiff + p.start_hour - Time.now.hour

        user_productions << p if hourDiff < 30 && p.reminded == false
      end
      msg = productions_reminder user, user_productions
      msg.deliver
      user_productions.each { |prod| prod.update_attribute(reminded: true) }
    end
  end

  def weekly_reminder
    # This method is regularly called by cron
    Production.all.each do |p|
      # TODO
    end
  end
end
