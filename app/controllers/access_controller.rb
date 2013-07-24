class AccessController < ApplicationController

  layout "admin"

  def index
    menu
    render('menu')
  end

  def menu
    # display text & links
  end

  def login
    # login form
  end

  def attempt_login
    authorized_user = AdminUser.authenticate(params[:username], params[:password])
    if authorized_user
      # TODO mark user as logged in
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "You have successfully logged in"
      redirect_to(:action => "menu")
    else
      flash[:notice] = "Invalid username or password"
      redirect_to(:action => "login")
    end
  end

  def logout
    # TODO: mark user as logged out
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You have logged out"
    redirect_to(:action => "login")
  end

end
