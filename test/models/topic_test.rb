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

  test 'parent topics have #recursive_questions_count reflecting the sum of all children' do
    parent = topics(:one)
    child = topics(:child)
    child.questions.create(text: 'Another child question')

    assert_equal 1, child.reload.questions_count
    assert_equal 2, parent.reload.questions_count
    assert_equal 1 + 2, parent.recursive_questions_count
  end

end
