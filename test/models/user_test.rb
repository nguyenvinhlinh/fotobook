require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "is_admin" do
    is_admin_admin = users(:admin).admin?
    is_user_admin = users(:user).admin?
    assert(is_admin_admin, "Admin is admin")
    assert_not(is_user_admin, "User is not an admin")
  end
end
