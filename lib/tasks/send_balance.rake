task :send_balance => :environment do
  Regatta.all.each do |regatta|
    if regatta.enddate.to_date <= 7.days.ago.to_date && regatta.balance.closed == false
      regatta.users.each do |user|
        BalanceMailer.send_balance(regatta, user).deliver_now
      end
    end
  end
end
