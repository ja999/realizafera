every 2.hours do
  # Run reminder on incoming productions
  runner "ProductionMailer.send_productions_reminder"
end

every 29.minutes do
  # Run productions cleaner
  runner "Production.clean_ongoing_production"

end

every :sunday do
  # Run week reminder
  runner "ProductionMailer.weekly_reminder"
end
