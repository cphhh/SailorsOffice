task :registration_reminder => :environment do
  Regatta.all.each do |regatta|
    if regatta.registration_deadline.to_date == 2.days.from_now.to_date && regatta.registrated == false
      regatta.users.each do |user|
        BalanceMailer.registration_reminder(regatta, user).deliver_now
      end
    end
  end
end
