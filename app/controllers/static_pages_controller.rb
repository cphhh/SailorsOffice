# StaticPagesController
class StaticPagesController < ApplicationController
  STARTAMOUNT = 836.26

  def home
		sixweeksago = Date.today - 42
		insixweeks = Date.today + 42
    @regattas = Regatta.order(startdate: :asc).where('startdate > ? AND startdate < ?', sixweeksago, insixweeks )

    userid = User.all.find(current_user.id)

    # Update balances for every regatta and user
    updatebalances(userid)

    depositsusersum = Deposit.where(user_id: userid).sum(:amount)
    costsusersum = RegattaUser.where(user_id: userid).sum(:balance)
    @currentbalance = depositsusersum - costsusersum

    # Fees and Supplements
    dt = Date.today
    boy = dt.beginning_of_year
    eoy = dt.end_of_year
    regattauseroy = RegattaUser.joins(:regatta).merge(Regatta.where("startdate >= ? and startdate <= ?", boy, eoy))
    usersfees = regattauseroy.where(user_id: userid).sum(:fee)
    userssupp = regattauseroy.where(user_id: userid).sum(:supplement)
    @userfeesupp = usersfees + userssupp

    # Total spendings
    @totalspendings = regattauseroy.where(user_id: userid).sum(:costs)

    #depositssum = Deposit.all.sum(:amount)
    #fee, supp, costs, expenses
    #fee = RegattaUser.sum(:fee)
    #supp = RegattaUser.sum(:supplement)
    #feesuppsum = fee + supp
    #costssum = Invoice.all.sum(:price)
    #@tintoaccountbalance = STARTAMOUNT - costssum
  end

  private

  def updatebalances(userid)
    Balance.all.each do |balance|
      users = balance.regatta.users.all

      users.each do |user|
        invoices = balance.regatta.invoices.all
        userinvoices = invoices.where(user_id: user.id)
        costs = invoices.sum(:price)
        expenses = userinvoices.sum(:price)
        fee = ((balance.regatta.enddate - balance.regatta.startdate).to_i + 1)*balance.regatta.fee
        supp = (((costs/users.count)/100)*balance.regatta.supplement).round(2)
        usercosts = (costs/users.count) + fee + supp
        userbalance = ((costs / users.count) + supp + fee) - expenses

        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(balance: userbalance)
        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(costs: usercosts)
        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(fee: fee)
        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(supplement: supp)
        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(expenses: expenses)
      end
    end
  end
end
