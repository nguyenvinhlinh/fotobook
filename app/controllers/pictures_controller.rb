class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  # GET /pictures
  # GET /pictures.json
  def index
   # tags_string = params[:tags]
    #tags_array = tags_string.split(", ")
    #for tag in tags_array
    #  puts tag
    #end  
    @pictures = Picture.all
    respond_to do |format|
      format.html
      format.json{render json: @pictures}
    end
    
  end
  
  # GET /pictures/1
  # GET /pictures/1.json
  def show
    
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
    @tags_string = String.new
  end

  # GET /pictures/1/edit
  def edit
  end
  
  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.save
    #create new tag based on the param
    @tags_string = params[:tags_string]
    _tagArray = @tags_string.split(",").map(&:strip)
    _tagArray.uniq
    
    @tags = Array.new
    for i in 0..._tagArray.size
      puts ("Index: #{i}, tag: #{_tagArray[i]}")
      _tag = Tag.find(_tagArray[i])
      if _tag != nil
        @tags[i] = _tag
      else
        _tag = Tag.new({:tag => _tagArray[i]})
        _tag.save
        @tags[i] = _tag
      end
      sql_insert_pictures_tags =
        "INSERT INTO pictures_tags (picture_id, tag_id) VALUES (#{@picture.id}, #{@tags[i].id})"
      ActiveRecord::Base.connection.execute(sql_insert_pictures_tags)
    end
    
    respond_to do |format|
      format.html { redirect_to action: "index" }
      # if @picture.save
      #   format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
      #   format.json { render :show, status: :created, location: @picture }
      # else
      #   format.html { render :new }
      #   format.json { render json: @picture.errors, status: :unprocessable_entity }
      # end
    end
  end

  def searchByTag
    
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  # 
  # def ac_by_tag
  #   @pictures = Picture.search(params[:term])
  #   _tags = Array.new
  #   @pictures.each do |picture|
  #     _tags << picture.tags
  #   end
  #   respond_to do |format|
  #     format.json{render json: _tags}
  #   end
  # end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
#      params.require(:picture).permit(:url, tags_attributes: [:id, :tag])
      params.require(:picture).permit(:url, {:tag_ids => []})
    end
end
