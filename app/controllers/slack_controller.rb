class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message  = params.require(:slack).permit(:text)
    render :plain => "Neue Rechnung erstellt push #{message}"
  end

  def position_params
  params.require(:position).permit(:lat, :lo, :speed, :game, :player)
  end
end
