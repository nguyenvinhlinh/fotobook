class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :destroy ]
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
    @tag.destroy
    respond_to do |format|
      format.html {redirect_to tags_url, notice: 'tag was successfully destroyed'}
    end
  end
  
  def show
  end

  private
  def set_tag
    @tag = Tag.find(params[:id])
  end
  
  def tag_params
    params.require(:tag).permit(:tag, {:picture_ids => []})
  end
end
