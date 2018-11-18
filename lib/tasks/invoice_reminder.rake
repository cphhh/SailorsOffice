task :invoice_reminder => :environment do
  Regatta.all.each do |regatta|
    if regatta.enddate.to_date == 2.days.ago.to_date
      ReminderMailer.invoice_reminder(regatta).deliver_now
    end
  end
end
