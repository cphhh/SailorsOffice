class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message  = params[:text]
    words = message.split
    user = params[:user_name]
    regatta_name = params[:channel_name]
    regatta = Regatta.where(name: regatta_name)
    regattaid = regatta[:id]

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

    render :plain => "Die Rechnung von #{words.first} bei der #{regatta_name} Regatta über #{words.second}€ wurde erstellt.}"
    Invoice.create(regatta_id: regattaid, user_id: user, name: words.second, price: words.third)
  end

end
