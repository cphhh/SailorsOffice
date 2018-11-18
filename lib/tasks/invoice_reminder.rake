task :invoice_reminder => :environment do
  Regatta.all.each do |regatta|
    if regatta.enddate.to_date == 2.days.ago.to_date
      regatta.users.each do |user|
        ReminderMailer.invoice_reminder(regatta, user).deliver_now
      end
    end
  end
end
