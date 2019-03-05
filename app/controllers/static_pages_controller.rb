# StaticPagesController
class StaticPagesController < ApplicationController
  def home
		sixweeksago = Date.today - 42
		insixweeks = Date.today + 42
    @regattas = Regatta.order(startdate: :asc).where('startdate > ? AND startdate < ?', sixweeksago, insixweeks )

    startamount = 836,26
    
  end
end
