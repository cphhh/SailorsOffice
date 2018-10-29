class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    message  = params.require(:slack).permit(:text)
    render :plain => "Neue Rechnung erstellt push #{message}"
  end

end
