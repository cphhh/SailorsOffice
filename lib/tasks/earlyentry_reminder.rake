task :earlyentry_reminder => :environment do
  Regatta.all.each do |regatta|
    if regatta.early_entry_deadline.to_date == 4.days.from_now.to_date && regatta.paid == false
      regatta.users.each do |user|
        BalanceMailer.earlyentry_reminder(regatta, user).deliver_now
      end
    end
  end
end
