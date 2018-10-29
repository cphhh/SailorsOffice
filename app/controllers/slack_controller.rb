class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message = params['slack']
    render :plain => "Neue Rechnung erstellt push"
  end
end
