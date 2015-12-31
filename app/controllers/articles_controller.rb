# encoding: utf-8

class ArticlesController < ApplicationController
	def index
		@articles = Article.order(released_at: :desc)
	end 

	def show
		@article = Article.find(params[:id])
	end 

	def new
		@article = Article.new
	end 

	def create
		@article = Article.new(params[:article])
		if @article.save
			redirect_to @article, notice: "記事を登録しました"
		else
			render "new"
		end 
	end 

	def edit
		@article = Article.find(params[:id])
	end 

	def update
		@article = Article.find(params[:id])
		@article.assign_attributes(params[:article])		
		if @article.save
			redirect_to @article, noticle: "記事を更新しました"
		else
			render "edit"
		end 
	end 

	def destroy
		@article = Article.find(param[:id])
		@article.destroy
		redirect_to :articles
	end 


end
