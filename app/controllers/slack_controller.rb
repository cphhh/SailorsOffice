class SlackController < ApplicationController
  def create
    @imessage = params[:slack]
  end
end
