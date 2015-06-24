class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  # GET /pictures
  # GET /pictures.json
  def index
    @page_tags = params[:tags]
    page_number = params[:page]
    page_number = 1 if page_number == nil
    if @page_tags == nil || @page_tags == ""
      @pictures = Picture.page(page_number).per(9)
    else
      tag_array = @page_tags.split(",").map(&:strip).uniq
      tag_array.delete ""
      sql_query =
        "SELECT p.id, p.url from pictures p inner join pictures_tags pt on p.id = pt.picture_id  inner join tags t on pt.tag_id = t.id WHERE"
      for i in 0...tag_array.size
        if i == 0
          sql_query += " t.tag LIKE '%#{tag_array[i]}%' "
        else
          sql_query += " OR t.tag LIKE '%#{tag_array[i]}%' "
        end
      end
      record_array = ActiveRecord::Base.connection.execute(sql_query)

      @pictures = Array.new
      for i in 0...record_array.size
        record_array[i].delete 0
        record_array[i].delete 1
        _picture = Picture.new(record_array[i])
        @pictures << _picture
      end
      
      @pictures  = Kaminari.paginate_array(@pictures).page(params[:page]).per(25)
    end
    respond_to do |format|
      format.html
      format.json{render json: @pictures}
    end  
  end
  
  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.includes(:tags).find(params[:id])
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
    _tagArray.delete ""
    

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
    end
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
