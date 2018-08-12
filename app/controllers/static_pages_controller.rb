class StaticPagesController < ApplicationController
  def home
  end

  def myregattas
    @user = User.find(current_user.id)
  end
end
