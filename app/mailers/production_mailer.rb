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
    @url = 'www.realizafera.herokuapp.com/login'
  	mail(to: @user.email, subject: 'Witaj w serwisie RealizAfera!')
  end

  def productions_reminder user, productions
    @user = user.decorate
    @productions = productions
    @url = "www.realizafera.herokuapp.com/my_productions"

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
      user_productions = []
      productions.each do |p|
        dayDiff = (p.start_day + 7 - Time.now.wday) % 7
        hourDiff = 24 * dayDiff + p.start_hour - Time.now.hour

        user_productions << p if hourDiff < 30 && p.reminded == false
      end
      if user_productions.length > 0
        msg = productions_reminder user, user_productions
        msg.deliver
        user_productions.each { |prod| prod.update_attribute(:reminded, true) }
      end
    end
  end

  def production_opening user_from, user_to, production
    @user_to = user_to.decorate
    @user_from = user_from.decorate
    @production = production.decorate
    @url = "www.realizafera.herokuapp.com/exchange"

    smtp_settings = {
      port: 587,
      domain:               "mail.a4w.pl",
      user_name:            "artur",
      password:             "",
      authentication:       "plain",
      enable_starttls_auto: true,
    }

    mail(to: @user_to.email, subject: 'RealizAfera - potrzebna pomoc! Wolna realizacja na giełdzie!')
  end

  def send_production_opening current_user, production
    allUsers = User.all
    users = []
    
    allUsers.each do |usr|
      if usr.got_free_spot_for(production)
        users << usr
      end
    end

    users.flatten.compact.each do |user_to|
      msg = production_opening current_user, user_to, production
      msg.deliver
    end
  end

  def self.weekly_reminder
    # This method is regularly called by cron
    Production.all.each do |p|
      # TODO
    end
  end
end
