# StaticPagesController
class StaticPagesController < ApplicationController
  STARTAMOUNT = 836.26

  def home
    if logged_in?
  		sixweeksago = Date.today - 42
  		insixweeks = Date.today + 42
      @regattas = Regatta.order(startdate: :asc).where('startdate > ? AND startdate < ?', sixweeksago, insixweeks )

      userid = User.all.find(current_user.id).id

      # Update balances for every regatta and user
      updatebalances(userid)

      # Fees and Supplements
      dt = Date.today
      boy = dt.beginning_of_year
      eoy = dt.end_of_year
      regattauseroy = RegattaUser.joins(:regatta).merge(Regatta.where("startdate >= ? and startdate <= ?", boy, eoy))
      regattauserbt = regattauseroy.joins(:regatta).merge(Regatta.where("startdate <= ?", Date.today))
      usersfees = regattauserbt.where(user_id: userid).sum(:fee)
      userssupp = regattauserbt.where(user_id: userid).sum(:supplement)
      @userfeesupp = usersfees + userssupp

      # User balance
      depositsusersum = Deposit.where(user_id: userid).sum(:amount)
      costsusersum = RegattaUser.where(user_id: userid).sum(:balance)
      regattauserat = RegattaUser.joins(:regatta).merge(Regatta.where("startdate >= ?", Date.today))
      futureusersfees = regattauserat.where(user_id: userid).sum(:fee)
      futureuserssupp = regattauserat.where(user_id: userid).sum(:supplement)
      currentbalance = depositsusersum - costsusersum + futureusersfees + futureuserssupp

      # Total spendings
      @totalspendings = regattauseroy.where(user_id: userid).sum(:costs) - futureusersfees - futureuserssupp

      #depositssum = Deposit.all.sum(:amount)
      #fee, supp, costs, expenses
      #fee = RegattaUser.sum(:fee)
      #supp = RegattaUser.sum(:supplement)
      #feesuppsum = fee + supp
      #costssum = Invoice.all.sum(:price)
      #@tintoaccountbalance = STARTAMOUNT - costssum

    end
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
        supp = (((costs/users.count)/100)*balance.regatta.supplement).ceil
        usercosts = (costs/users.count).ceil + fee + supp
        userbalance = usercosts - expenses

        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(balance: userbalance)
        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(costs: usercosts)
        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(fee: fee)
        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(supplement: supp)
        balance.regatta.regatta_users.find_by(user_id: user.id).update_attributes(expenses: expenses)
      end
    end
  end
end
