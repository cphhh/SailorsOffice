class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message  = params[:text]
    words = message.split
    render :plain => "Die Rechnung von #{words.second} bei der #{words.first} Regatta über #{words.third}€ wurde erstellt."
    regatta = Regatta.id.where(:name => words.first)
    Invoice.create(regatta_id: regatta, user_id: 1, name: words.second, price: words.third )
  end

end
