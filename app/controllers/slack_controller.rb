class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message  = params[:text]
    words = message.split
    regattaid = Regatta.where(:name => words.first)[0][:id]
    render :plain => "Die Rechnung von #{words.second} bei der #{words.first} Regatta über #{words.third}€ wurde erstellt. #{regattaid}"
    Invoice.create(regatta_id: regattaid, user_id: 1, name: words.second, price: words.third)
  end

end
