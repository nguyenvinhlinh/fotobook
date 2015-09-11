require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
  setup do
    @picture = pictures(:picture1)
    @user = users(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pictures)
  end

  test "should not get new without authentication" do
    get :new
    assert_response :redirect
  end
  
  test "should not create picture without authetication" do
    assert_no_difference('Picture.count') do
      post :create, picture: {url: @picture.url}, tags_string: "boy, girl, world"
    end
    assert_response :redirect
  end

  test "should show picture" do
    get :show, id: @picture
    assert_response :success
  end

  test "should not get edit without authentication" do
    get :edit, id: @picture
    assert_response :redirect
  end

  test "should not update picture without authentication" do
    patch :update, id: @picture, picture: { tags: @picture.tags, url: @picture.url }
    assert_redirected_to new_user_session_path
  end

  test "should not destroy picture without authentication" do
    assert_no_difference('Picture.count', -1) do
      delete :destroy, id: @picture
    end
    assert_redirected_to new_user_session_path
  end

  test "should not see my picture without authentication" do
    get :myIndex
    assert_redirected_to new_user_session_path
  end

  test "should see my picture with authentication" do
    sign_in @user
    assert_response :success
  end
  
  test "should create picture with authentication" do
    sign_in @user
    assert_difference '@user.pictures.count', 1 do
      post :create, picture: {url: @picture.url}, tags_string: "boy, girl, world"
    end
  end

  test "should update pictures with authorization" do
    sign_in @user
    @user.pictures << @picture
    patch :update, id: @picture, picture: { tags: "t1, t2, t4", url: @picture.url }
    assert_redirected_to picture_path(@picture)
  end

  test "should not update picture with wrong authorization" do
    sign_in @user
    patch :update, id: @picture, picture: { tags: "t1, t2, t4", url: @picture.url }
    assert_redirected_to new_user_session_path
  end

  test "should delete picture with authorization" do
    sign_in @user
    @user.pictures << @picture
    assert_difference "Picture.count", -1 do
      delete :destroy, id: @picture
    end
    assert_redirected_to pictures_path
  end
  
  test "should not delete picture with wrong authorization" do
    sign_in @user
    assert_no_difference "Picture.count" do
      delete :destroy, id: @picture
    end
    assert_redirected_to new_user_session_path
  end
end
