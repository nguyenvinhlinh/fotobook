include Utilities
class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource 
  respond_to :html, :json
  # GET /pictures
  # GET /pictures.json
  NUMBER_OF_PICTURES_PER_PAGE = 10
  def index
    page_number = (params[:page].nil? || params[:page].to_i < 1) ? 1 : params[:page]
    @page_tags = params[:tags]
    if @page_tags.blank?
      @pictures = Kaminari.paginate_array(Picture.all.reverse).page(page_number).per(NUMBER_OF_PICTURES_PER_PAGE)
    else
      _tag_array = stringToArray(@page_tags)
      picture_array = Picture.searchByTagArray(_tag_array)
      @pictures  = Kaminari.paginate_array(picture_array).page(params[:page]).per(NUMBER_OF_PICTURES_PER_PAGE)
    end
    respond_to do |format|
      format.html
      format.json{render json: @pictures}
    end
  end
  
  def myIndex
    if user_signed_in? 
      page_number = (params[:page].nil? || params[:page].to_i < 1) ? 1 : params[:page]
      @pictures = Kaminari.paginate_array(current_user.pictures).page(page_number).per(NUMBER_OF_PICTURES_PER_PAGE)
      respond_to do |format|
        format.html{render template: "/pictures/my_index.html.erb" }
        format.json{render json: @pictures}
      end
    else
      redirect_to new_user_session
    end
  end
  
  def loadAjaxAllImage
    page_number = params[:page]
    pictures = Kaminari.paginate_array(Picture.all.reverse).page(page_number).per(NUMBER_OF_PICTURES_PER_PAGE)
    dom_element = "<img src='%s' href='%s'  hrefto='/pictures/%s' rel='pictures' />"
    return_html_array = []
    pictures.each do |p|
      return_html_array << [p.url, dom_element % [p.url, p.url, p.id]]
    end
    json = {
      images: return_html_array
    }
    respond_to do |format|
      format.json{render json: json}
    end
  end

  def loadAjaxImageByTag
  end

  def loadAjaxImageByUsername
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
        tags_string = params[:tags_string]
        tag_array = stringToArray tags_string
        @picture.tags.clear
        @picture.tags << tag_array.map {
          |t|
          tag = Tag.find_by(tag: t)
          if tag.nil?
            tag = Tag.new(tag: t)
          end
          tag
        }
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      end
    else
      redirect_to new_user_session_path
    end
  end
  
  def destroy
    if is_belong_to_current_user
      @picture.tags.clear
      @picture.destroy
      respond_to do |format|
        format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to new_user_session_path
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
      if not user_signed_in?
        return false
      end
      return current_user == @picture.user
    end
end
