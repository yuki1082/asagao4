# encoding: utf-8

class MembersController < ApplicationController
  before_action :login_required
  def index
    @members = Member.order(:number).paginate(page: params[:page], per_page: 15)
  end

  def show
    @member = Member.find(params[:id])
    if params[:format].in?(["jpg","png","gjf"])
      send_image
    else
      render "show"
    end
  end

  def search
    @members = Member.search(params[:q]).paginate(page: params[:page], per_page: 15)
    render :index
  end
  
  private
   def send_image
    if @member.image.present?
      send_data @member.image.data,
        type: @member.image.content_type, disposition: "inline"
    else
      raise NotFound
    end
  end
end
