require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "#parent_path provides an array of parent topics all the way up to the top parent" do
    parent = topics(:one)
    child = topics(:child)
    child_child = child.subtopics.create(title: 'child_child_topic')
    child_child_child = child_child.subtopics.create(title: 'child_child_child_topic')
    assert_equal([child_child, child, parent], child_child_child.parent_path)
  end
end
