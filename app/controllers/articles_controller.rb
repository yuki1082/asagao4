# encoding: utf-8

class ArticlesController < ApplicationController
  before_action :login_required, except:[:index, :show]
  def index
    @articles = Article.readable_for(current_member).order(released_at: :desc).paginate(page: params[:page], per_page: 15)
  end

  def show
    @article = Article.readable_for(current_member).find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
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
    @article.assign_attributes(article_params)
    if @article.save
      redirect_to @article, noticle: "記事を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to :articles
  end

  private
  def article_params
    params.require(:article).permit(:title, :body,
                                    :released_at, :expired_at, :member_only)

  end

end
