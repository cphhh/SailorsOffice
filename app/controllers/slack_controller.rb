class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message  = params[:text]
    words = message.split
    user = params[:user_name]

    if user == 'maximilianbischof'
      user = 1
    end

    if user == 'christian'
      user = 2
    end

    if user == 'olewittenberg'
      user = 3
    end

    if user == 'bele.schuett'
      user = 4
    end

    if user == 'till.pomarius'
      user = 5
    end

    regattaid = Regatta.where(:name => words.first)[0][:id]
    render :plain => "Die Rechnung von #{words.second} bei der #{words.first} Regatta über #{words.third}€ wurde erstellt.}"
    Invoice.create(regatta_id: regattaid, user_id: user, name: words.second, price: words.third)
  end

end
