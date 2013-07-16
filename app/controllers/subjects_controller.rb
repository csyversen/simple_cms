class SubjectsController < ApplicationController
  
  layout "admin"

  def index
    list
    render('list')
    #redirect_to(:action => "list")
  end

  def list
    @subjects = Subject.order("subjects.position ASC")
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
    @subject.name = "default"

    @subject_count = Subject.count + 1
  end

  def create
    # instantiate a new object using form parameters
    @subject = Subject.new
    @subject.name = params[:subject][:name]
    @subject.position = params[:subject][:position]
    @subject.visible = params[:subject][:visible]

    # save the object
    if @subject.save
      # if the save succeeds, redirect to the list action
      flash[:notice] = "Subject created"
      redirect_to(:action => "list")
    else
      # if the save fails, redisplay the form so the user can fix problems
      @subject_count = Subject.count + 1
      render("new")
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count 
  end

  def update
    # instantiate a new object using form parameters
    @subject = Subject.find(params[:id])
    @subject.name = params[:subject][:name]
    @subject.position = params[:subject][:position]
    @subject.visible = params[:subject][:visible]

    # save the object
    if @subject.save
      # if the save succeeds, redirect to the list action
      flash[:notice] = "Subject updated"
      redirect_to(:action => "show", :id => @subject.id)
    else
      # if the save fails, redisplay the form so the user can fix problems
      @subject_count = Subject.count
      render("edit")
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    Subject.find(params[:id]).destroy
    flash[:notice] = "Subject destroyed"
    redirect_to(:action => "list")
  end

end
