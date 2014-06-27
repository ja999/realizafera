# IMPORTANT
# After you update this file you must run:
# $ whenever --update-crontab realizafera --set environment='development'
# Default environment is production


every 2.hours do
# every 2.minutes do
  # Run reminder on incoming productions
  command 'date > /robo/u1/semestr_6/AI/realizafera/reminder.mail.log'
  runner "ProductionMailer.send_productions_reminder"
end

every 29.minutes do
# every 3.minutes do
  # Run productions cleaner
  command 'date > /robo/u1/semestr_6/AI/realizafera/cleaner.mail.log'
  runner "Production.clean_ongoing_productions"
end

every :sunday do
# every 5.minutes do
  # Run week reminder
  command 'date > /robo/u1/semestr_6/AI/realizafera/weekly.mail.log'
  runner "ProductionMailer.weekly_reminder"
end
