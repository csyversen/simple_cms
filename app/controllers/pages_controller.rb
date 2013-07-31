class PagesController < ApplicationController

  layout "admin"
  before_filter :confirm_logged_in
  before_filter :find_subject

  def index
    list
    render("list")
  end

  def list
    @pages = Page.sorted.where(:subject_id => params[:subject_id])
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
    @page.subject_id = @subject_id
    @page_count = @subject.pages.size + 1
    @subjects = Subject.order("position ASC")
  end

  def edit
    @page = Page.find(params[:id])
    @page_count = @subject.pages.size
    @subjects = Subject.order("position ASC")
  end

  def update
    @page = Page.find(params[:id])
    @page.name = params[:page][:name]
    @page.permalink = params[:page][:permalink]
    #@page.position = params[:page][:position]
    @page.visible = params[:page][:visible]

    if @page.save
      @page.move_to_position(params[:page][:position])

      flash[:notice] = "Page updated"
      redirect_to(:action => "show", :id => @page.id, :subject_id => @page.subject_id)
    else
      @page_count = @subject.pages.count
      @subjects = Subject.order("position ASC")
      render("edit")
    end
  end

  def create
    @page = Page.new
    #save all the page attributes
    @page.name = params[:page][:name]
    @page.permalink = params[:page][:permalink]
    #@page.position = params[:page][:position]
    @page.visible = params[:page][:visible]
    @page.subject_id = params[:page][:subject_id]

    if @page.save
      @page.move_to_position(params[:page][:position])

      flash[:notice] = "Page created!"
      redirect_to(:action => "list", :subject_id => @page.subject_id)
    else
      @page_count = @page.subject_id + 1
      @subjects = Subject.order("position ASC")
      render("new")
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id])
    page.move_to_position(nil)
    page.destroy
    flash[:notice] = "Page destroyed"
    redirect_to(:action => "list", :subject_id => @subject.id)
  end


############################################
  private
############################################
  def find_subject
    if params[:subject_id]
      @subject = Subject.find_by_id(params[:subject_id])
    end
  end


end

