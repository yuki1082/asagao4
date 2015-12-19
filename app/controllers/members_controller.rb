class MembersController < ApplicationController
  def index
  	@members = Member.order(:number)
  end

  def show
  	@member = Member.find(params[:id])
  end

  def new
  end


  def create
  end


  def edit
  end

  def update
  end 

  def destory
  end

  def search
  	@members = Member.search(params[:q])
  	render :index
  end  
end
