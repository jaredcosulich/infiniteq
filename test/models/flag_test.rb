require 'test_helper'

class FlagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'self.grouped_flags groups flags by reason' do
    question = questions(:one)
    3.times { |i| question.flags.create(action: trust, trust: (i + 1) * 100, reason: :out_of_date)}

    grouped_flags = Flag.grouped(question.flags)
    assert_equal 1, grouped_flags.length
    assert_equal 1, grouped_flags.not_disputed.length
    assert_equal 0, grouped_flags.disputed.length

    grouped_flag = grouped_flags.first
    assert_equal(600, grouped_flag.trust)
  end


  test 'self.grouped_flags groups flags by reason and checks for disputes' do
    question = questions(:one)
    2.times { |i| question.flags.create(action: trust, trust: i * 100, reason: :out_of_date)}
    question.flags.create(action: trust, trust: -1000, reason: :out_of_date, dispute: true)

    grouped_flags = Flag.grouped(question.flags)
    assert_equal 1, grouped_flags.length
    assert_equal 0, grouped_flags.not_disputed.length
    assert_equal 1, grouped_flags.disputed.length

    grouped_flag = grouped_flags.first
    assert_equal(0, grouped_flag.trust)
    assert grouped_flag.disputed?
  end
end
