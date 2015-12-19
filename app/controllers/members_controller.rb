# encoding: utf-8

class MembersController < ApplicationController
  def index
    @members = Member.order(:number)
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new(birthday: Date.new(1980, 1, 1))
  end


  def create
    @member = Member.new(params[:member])
    if @member.save
      redirect_to @member, notice: "登録しました"
    else
      render :new
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
  	@member = Member.find(params[:id])
  	@member.assign_attributes(params[:member])
  	if @member.save
  		redirect_to @member, notice: "更新しました"
  	else
  		render :edit
  	end 
  end

  def destroy
  	@member = Member.find(params[:id])
  	@member.destroy
  	redirect_to :members, notice: "削除しました"
  end

  def search
    @members = Member.search(params[:q])
    render :index
  end
end
