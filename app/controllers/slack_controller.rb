class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message = params.require[:slack]
    text = message['text']

    render :plain => "Neue Rechnung erstellt push #{text}"
  end
end
