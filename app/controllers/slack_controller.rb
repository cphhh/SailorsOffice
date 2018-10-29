class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message  = params[:text]
    words = message.split
    render :plain => "Die Rechnung von #{words.second} bei der #{words.first} Regatta über #{words.third}€ wurde erstellt."
    Invoice.create(regatta_id: Regatta.select(:id).where(:name => words.first), user_id: 1, name: words.second, price: words.third)
  end

end
