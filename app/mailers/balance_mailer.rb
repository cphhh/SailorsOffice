require 'digest/sha2'
class BalanceMailer < ApplicationMailer
  default from: 'tinto@bischof.dk'
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@bischof.dk"

  def invoice_reminder(regatta, user)
		begin
    	@regatta = regatta
    	@user = user
    	mail(to: user.email, subject: "Please submit invoices from #{regatta.name} regatta")
		rescue Net::SMTPAuthenticationError
			retry
		end
  end

  def send_balance(regatta, user)
    @regatta = regatta
    @user = user
    @balance = @regatta.balance
    @users = @balance.regatta.users.all
    @costs = @balance.regatta.invoices.all.sum(:price)
    @feerate = @balance.regatta.fee
		@supp = @balance.regatta.supplement
    @supplement = (((@costs/@users.count)/100)*@supp).round(2)
    @fee = ((@balance.regatta.enddate - @balance.regatta.startdate).to_i + 1)*@feerate
    @totalcosts = ((@costs / @users.count) + @supplement + @fee)
    @totalprofit = (@users.count*@supplement) + (@users.count*@fee)
		@invoices = @balance.regatta.invoices
    mail(to: user.email, subject: "Balance for #{regatta.name} regatta")
    @balance.update(:closed => true, :closing_date => Date.today)
  end
end
