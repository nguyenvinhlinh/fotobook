include Utilities
class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 
  respond_to :html, :json
  # GET /pictures
  # GET /pictures.json
  def index
    page_number = (params[:page].nil? || params[:page].to_i < 1) ? 1 : params[:page]
    @page_tags = params[:tags]
    if @page_tags.blank?
      @pictures = Kaminari.paginate_array(Picture.all.reverse).page(page_number).per(11)
    else
      picture_array = Picture.searchPictureByTagArray(tag_array.split(','))
      @pictures  = Kaminari.paginate_array(picture_array).page(params[:page]).per(11)
    end
    respond_to do |format|
      format.html
      format.json{render json: @pictures}
    end
  end
  
  def myIndex
    if user_signed_in? 
      page_number = (params[:page].nil? || params[:page].to_i < 1) ? 1 : params[:page]
      @pictures = Kaminari.paginate_array(current_user.pictures).page(page_number).per(11)
      respond_to do |format|
        format.html{render template: "/pictures/index.html.erb" }
        format.json{render json: @pictures}
      end
    else
      redirect_to new_user_session
    end
  end
  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.includes(:tags).find(params[:id])
    @is_belong_to_current_user = is_belong_to_current_user
  end
  
  # GET /pictures/new
  def new
    @picture = Picture.new
    @tags_string = String.new
  end

  def upload
    @picture = Picture.new
    @tags_string = String.new
  end
  
  def edit
    redirect_to new_user_session_path if not is_belong_to_current_user
  end
  
  def create
    picture = Picture.new(picture_params)
    tag_array = stringToArray params[:tags_string]
    picture.tags << tag_array.map do |tag_s|
      tag = Tag.find_by(tag: tag_s)
      if tag.nil?
        tag = Tag.new(tag: tag_s)
      end
      tag
    end
    isSave = true
    if user_signed_in?
      current_user.pictures << picture
    else
      isSave = picture.save
    end
    respond_to do |format|
      if isSave
        format.html {redirect_to pictures_path, notice: 'Picture was saved'}
      else
        format.html {redirect_to new_picture_path, notice: 'Picture failed to save'}
      end
    end
  end
  
  def update
    if is_belong_to_current_user
      respond_to do |format|
        if @picture.update(picture_params)
          format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
          format.json { render :show, status: :ok, location: @picture }
        else
          format.html { render :edit }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_user_session
    end
  end
  
  def destroy
    @picture.tags.clear
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
      params.require(:picture).permit(:url)
    end
    
    def is_belong_to_current_user
      return current_user == @picture.user
    end
end
