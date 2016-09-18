require 'test_helper'

class FlagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flag = flags(:one)
  end

  test "should get index" do
    get flags_url
    assert_response :success
  end

  test "should get new" do
    get new_flag_url
    assert_response :success
  end

  test "should create flag" do
    user = users(:registered)
    follower_users = [users(:another_registered), users(:unconfirmed)]
    question = @flag.question
    follower_users.each do |follower_user|
      question.followings.create(user: follower_user)
    end

    sign_in user

    assert_difference('Flag.count') do
      post flags_url, params: { flag: { action: 'trust', details: @flag.details, question_id: @flag.question_id, reason: @flag.reason, trust: @flag.trust } }
    end

    Delayed::Worker.new.work_off

    follower_users.each do |follower_user|
      assert follower_email = ActionMailer::Base.deliveries.select { |e| e.to == [follower_user.email] }.last
      assert_equal "InfiniteQ: Flag added to question: #{question.text}", follower_email.subject
      assert_equal ['support@infiniteq.net'], follower_email.from
      assert follower_email.encoded.include? @flag.reason_string
      assert follower_email.encoded.include? 'unsubscribe'
    end

    assert_response :success
    assert_select '.vote-total', /-1.9/
  end

  test "should show flag" do
    get flag_url(@flag)
    assert_response :success
  end

  test "should get edit" do
    get edit_flag_url(@flag)
    assert_response :success
  end

  test "should update flag" do
    patch flag_url(@flag), params: { flag: { action: 'trust', details: @flag.details, question_id: @flag.question_id, reason: @flag.reason, trust: @flag.trust, user_id: @flag.user_id } }
    assert_redirected_to flag_url(@flag)
  end

  test "should destroy flag" do
    object = @flag.object
    assert_difference('Flag.count', -1) do
      delete flag_url(@flag)
    end

    assert_redirected_to object
  end
end
