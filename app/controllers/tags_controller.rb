class TagsController < ApplicationController
  allow_cors :ac_by_tag
  before_action :set_tag, only: [:show, :destroy ]
  
  load_and_authorize_resource
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new({:tag =>params[:tag][:tag]})
    _isSaved = @tag.save 
    respond_to do |format|
      
      if _isSaved
        format.html { redirect_to @tag, notice: 'Tag was successfully created'}
      else
        format.html { render :new}
      end
    end
  end
  
  def index
    @tags = Tag.all
  end
  
  def destroy
    if current_user.admin?
      @tag.pictures.clear
      @tag.destroy
      respond_to do |format|
        format.html {redirect_to tags_url, notice: 'tag was successfully destroyed'}
      end
    else
      redirect_to new_user_session_path
    end
  end
  
  def show
    @tag = Tag.includes(:pictures).find_by(tag:  params[:tag_name])
    @pictures = @tag.pictures.first(10);
  end

  def ac_by_tag
    tags = Tag.where("tag LIKE '%#{params[:term].strip}%'")
    respond_to do |f|
      f.json {
        render :json => tags.map {|t| t.tag}
      }
    end
  end
  
  private
  def set_tag
    @tag = Tag.find_by(tag: params[:tag_name])
  end
  
  def tag_params
    params.require(:tag).permit(:tag, {:picture_ids => []})
  end
end
