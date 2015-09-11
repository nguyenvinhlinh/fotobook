require 'test_helper'
class TagTest < ActiveSupport::TestCase
  test "should reject empty tag name" do
    a_tag = Tag.new(tag: '')
    is_save = a_tag.save
    assert_not(is_save, "Creating new tag with empty tag name will be failed")
  end

  test "should reject nul tag name" do
    a_tag = Tag.new()
    is_save = a_tag.save
    assert_not(is_save, "Creating new tag with null tag name will be failed")
  end

  test "should reject duplicated tag name" do
    tag = Tag.new(tag: 'world')
    is_save = tag.save
    assert_not(is_save, "The tag name has been used")
  end

  test "should reject tag with length 1" do
    tag = Tag.new(tag: 'a')
    is_save = tag.save
    assert_not(is_save, "The tag's length is 1, invalid")
    tag.destroy
  end

  test "should accept tag with length 2" do
    tag = Tag.new(tag: 'aa')
    is_save = tag.save
    assert(is_save, "The tag's length is 2, valid")
    tag.destroy
  end

  test "should accept tag length 15" do
    tag = Tag.new(tag: 'aaaaaaaaaaaaaaa')
    is_save = tag.save
    assert(is_save, "The tag's length is 15, valid")
    tag.destroy
  end

  test "should accept tag length 16" do
    tag = Tag.new(tag: 'uuuuuuuuuuuuuuuu')
    is_save = tag.save
    assert_not(is_save, "The tag's length is 16, invalid")
    tag.destroy
  end
end
