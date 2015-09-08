require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "is_admin" do
    is_admin_admin = users(:admin).admin?
    is_user_admin = users(:user).admin?
    assert(is_admin_admin, "Admin's role is admin")
    assert_not(is_user_admin, "User's role is not an admin")
  end

  test "is_user" do
    is_admin_user = users(:admin).user?
    is_user_user = users(:user).user?
    assert_not(is_admin_user, "Admin's role is not an user")
    assert(is_user_user, "User's role is an user")
  end
end
