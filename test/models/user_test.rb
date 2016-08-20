require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user's trust goes up to 10 when confirmed" do
    user = users(:unconfirmed)
    assert_equal 1, user.trust

    user.confirm
    assert_equal 10, user.trust
  end

end
