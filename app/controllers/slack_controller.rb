class SlackController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    @params = params[:slack]
    render :text => 'Neue Rechnung erstellt'
  end
end
