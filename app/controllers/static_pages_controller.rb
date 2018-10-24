# StaticPagesController
class StaticPagesController < ApplicationController
  def home
    @nextregattas = Regatta.order(startdate: :asc).first(5)
  end
end
