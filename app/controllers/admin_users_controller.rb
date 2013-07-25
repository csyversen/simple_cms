class AdminUsersController < ApplicationController

  layout "admin"
  before_filter :confirm_logged_in

  def index
    redirect_to(:action => "list")
  end

  def list
    @admins = AdminUser.sorted
  end

  def new
    @admin = AdminUser.new
  end

  def create
  
    # instantiate a new object using form parameters
    @admin = AdminUser.new
    @admin.first_name = params[:admin_user][:first_name]
    @admin.last_name = params[:admin_user][:last_name]
    @admin.username = params[:admin_user][:username]
    @admin.email = params[:admin_user][:email]
    @admin.password = params[:admin_user][:password]

    # save the object
    if @admin.save
      # if the save succeeds, redirect to the list action
      flash[:notice] = "Admin created!"
      redirect_to(:action => "list")
    else
      # if the save fails, redisplay the form so the user can fix problems
      render("new")
    end


  end

  def edit
    @admin = AdminUser.find(params[:id])
  end

  def update
        # instantiate a new object using form parameters
    @admin = AdminUser.find(params[:id])
    @admin.first_name = params[:admin][:first_name]
    @admin.last_name = params[:admin][:last_name]
    @admin.username = params[:admin][:username]
    @admin.email = params[:admin][:email]
    @admin.password = params[:admin][:password]

    # save the object
    if @admin.save
      # if the save succeeds, redirect to the list action
      flash[:notice] = "Admin updated"
      redirect_to(:action => "list")
    else
      # if the save fails, redisplay the form so the user can fix problems
      render("edit")
    end
  end

  def delete
  end

  def destroy
  end
end
