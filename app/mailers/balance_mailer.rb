require 'digest/sha2'
class BalanceMailer < ApplicationMailer
  default from: 'tinto@bischof.dk'
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@bischof.dk"

  def invoice_reminder(regatta, user)
    @regatta = regatta
    @user = user
    mail(to: user.email, subject: "Please submit invoices from #{regatta.name} regatta")
  end

  def send_balance(regatta, user)
    @regatta = regatta
    @user = user
    @balance = @regatta.balances.first
    @users = @balance.regatta.users.all
    @costs = @balance.regatta.invoices.all.sum(:price)
    @supplement = (((@costs/@users.count)/100)*5).round(2)
    @fee = ((@balance.regatta.enddate - @balance.regatta.startdate).to_i + 1)*5
    @totalcosts = ((@costs / @users.count) + @supplement + @fee)
    @totalprofit = (@users.count*@supplement) + (@users.count*@fee)
    mail(to: user.email, subject: "Balance for #{regatta.name} regatta")
    @balance.update(:closed => true, :closing_date => Date.today)
  end
end
