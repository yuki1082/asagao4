class EntriesController < ApplicationController
  def index
    if params[:member_id]
      @member = Member.find(params[:member_id])
      @entries = @member.entries
    else
      @entries = Entry.all
    end
    @entries = @entries.readable_for(current_member).order(posted_at: :DESC)
    .paginate(page: params[:page], per_page: 5)
  end

  def show
    @entry = Entry.readable_for(current_member).find(params[:id])
  end

  def new
    @entry = Entry.new(posted_at: Time.current)
  end

  def edit
    @entry = current_member.entries.find(params[:id])
 #   @entry = Entry.find(params[:id])

  end

  def create
    @entry = Entry.new(entry_params)
    @entry.author = current_member
    if @entry.save
      redirect_to @entry, notice: "記事を作成しました"
    else
      render "new"
    end
  end

  def update
    @entry = current_member.entries.find(params[:id])
    @entry.assign_attributes(entry_params)
    if @entry.save
      redirect_to @entry, notice: " 記事を更新しました。 "
    else
      render "edit"
    end
  end

  def destroy
    @entry = current_member.entries.find(params[:id])
    @entry.destroy
    redirect_to :entries, notice: " 記事を削除しました。 "
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :body, :posted_at, :status)
  end




end
