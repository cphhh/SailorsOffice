# StaticPagesController
class StaticPagesController < ApplicationController
  def home
		sixweeksago = Date.today - 42
		insixweeks = Date.today + 42
    @regattas = Regatta.order(startdate: :asc).where('startdate > ? AND startdate < ?', sixweeksago, insixweeks )

    startamount = 836,26

    # Calucaltion for current balance for each user
    userid = User.all.find(current_user.id)

    userbalance(userid)

    depositssum = Deposit.where(user_id: userid).sum(:amount)
    costssum = RegattaUser.where(user_id: userid).sum(:balance)
    @currentbalance = depositssum - costssum
  end

  private

  def userbalance(userid)
    Balance.all.each do |balance|
      users = balance.regatta.users.all

      users.each do |user|
        invoices = balance.regatta.invoices.all
        userinvoices = invoices.where(user_id: user.id)
        costs = invoices.sum(:price)
        usercosts = userinvoices.sum(:price)
        fee = ((balance.regatta.enddate - balance.regatta.startdate).to_i + 1)*balance.regatta.fee
        supp = (((costs/users.count)/100)*balance.regatta.supplement).round(2)
        userbalance = ((costs / users.count) + supp + fee) - usercosts
        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(balance: userbalance)
      end
    end
  end
end
