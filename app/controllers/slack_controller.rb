class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    render :text => "Neue Rechnung erstellt push"
  end
end
