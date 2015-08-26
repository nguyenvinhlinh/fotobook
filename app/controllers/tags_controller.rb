class TagsController < ApplicationController
  allow_cors :ac_by_tag
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
    sql_delete = "DELETE FROM pictures_tags WHERE pictures_tags.tag_id = #{@tag.id}"
    ActiveRecord::Base.connection.execute(sql_delete)
    @tag.destroy
    respond_to do |format|
      format.html {redirect_to tags_url, notice: 'tag was successfully destroyed'}
    end
  end
  
  def show
    @tag = Tag.includes(:pictures).find_by(tag:  params[:tag_name])
  end

  def ac_by_tag
    tags = Tag.where("tag LIKE '%#{params[:term].strip}%'")
    respond_to do |f|
      f.json {render :json => tags.to_json(:only => ["tag"])  }
    end
  end
  private
  def set_tag
    @tag = Tag.find(params[:tag_name])
  end
  
  def tag_params
    params.require(:tag).permit(:tag, {:picture_ids => []})
  end
end
