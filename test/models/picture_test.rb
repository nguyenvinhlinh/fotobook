require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @picture = Picture.new
    @picture.url =
      "http://img2.wikia.nocookie.net/__cb20150203214239/naruto/images/8/88/Naruto_Exhibition_characters.png"
    @picture.save

    
  end

  def teardown
    @picture = nil
  end
  
  
  
  
  test "create_empty_picture" do
    picture = Picture.new
    assert_not picture.save 
  end

  test "create_good_picture" do
    picture = Picture.new
    picture.url = "https://upload.wikimedia.org/wikipedia/vi/0/06/DRMN_01.jpg"
    assert picture.save
  end

  test "read_invalid_picture" do
    begin
    picture = Picture.find(10000)
    rescue
      picture = nil
    end
    assert_not picture
  end

  test "read_valid_picture" do
    picture = Picture.where(id: 0)
    assert picture
  end

  test "update_image" do
    new_url =
      "http://e5c351ecddc2f880ef72-57d6ff1fc59ab172ec418789d348b0c1.r69.cf1.rackcdn.com/images/_x559FCalrCN.878x0.Z-Z96KYq.jpg"
    picture = Picture.first
    picture.url = new_url
    picture.save
    
    assert_equal new_url, Picture.find(picture.id).url, "Image is updated"
  end

  test "delete_image" do
    picture = Picture.first
    id = picture.id
    picture.destroy
    picture.save
    result = Picture.where(id: id)
    assert_not result
  end


end
