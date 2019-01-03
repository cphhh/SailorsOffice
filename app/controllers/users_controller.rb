# Users controller
class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :index, :new, :create, :update, :updaterids]

  def show
    @user = User.find(params[:id])
  end

  def new
    #@user = User.new
  end

  def create
    #@user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to Tinto Racing Team!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attribute(:regatta_ids, join_params.fetch(:regatta_ids))
    # flash[:success] = params[:regatta_ids => []]
    render template: 'regattas/joinregattas'
  end

  def updaterids
    @user = User.find(params[:id])
    @user.update_attribute(:regatta_ids, join_params.fetch(:regatta_ids []))
    # flash[:success] = params[:regatta_ids => []]
    render template: 'static_pages/myregattas'
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation, regatta_ids: []
    )
  end

  def join_params
    params.require(:user).permit(regatta_ids: [])
  end
end
