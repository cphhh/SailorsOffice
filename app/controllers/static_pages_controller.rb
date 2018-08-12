class StaticPagesController < ApplicationController
  def home
    @nextregattas = Regatta.order(startdate: :asc).first(5)
  end

  def myregattas
    @user = User.find(current_user.id)
  end
end
