class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message  = params[:text]
    words = message.split
    regattaid = Regatta.where(:name => words.first)
    render :plain => "Die Rechnung von #{words.second} bei der #{words.first} Regatta über #{words.third}€ wurde erstellt. #{regattaid[:id]}"
    Invoice.create(regatta_id: regattaid[:id], user_id: 1, name: words.second, price: words.third)
  end

end
