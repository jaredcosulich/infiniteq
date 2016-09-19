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
    user = users(:another_registered)
    question = questions(:one)

    sign_in user

    assert_difference('Flag.count') do
      post flags_url, params: { flag: { action: 'trust', details: 'Details', question_id: question.id, reason: @flag.reason, trust: @flag.trust } }
    end

    Delayed::Worker.new.work_off

    assert owner_email = ActionMailer::Base.deliveries.select { |e| e.to == [question.user.email] }.last
    assert_equal "InfiniteQ: Your question was flagged.", owner_email.subject
    assert_equal ['support@infiniteq.net'], owner_email.from
    assert owner_email.encoded.include? @flag.reason_string
    assert owner_email.encoded.gsub(/\r\n/, ' ').include? 'Another Registered Person flagged your question'

    assert_response :success
    assert_select '.vote-total', /0.9/
  end

  test "should create flag for an answer" do
    user = users(:another_registered)
    answer = answers(:one)

    sign_in user

    assert_difference('Flag.count') do
      post flags_url, params: { flag: { action: 'trust', details: 'Details', answer_id: answer.id, reason: @flag.reason, trust: @flag.trust } }
    end

    Delayed::Worker.new.work_off

    assert owner_email = ActionMailer::Base.deliveries.select { |e| e.to == [answer.user.email] }.last
    assert_equal "InfiniteQ: Your answer was flagged.", owner_email.subject
    assert_equal ['support@infiniteq.net'], owner_email.from
    assert owner_email.encoded.include? @flag.reason_string
    assert owner_email.encoded.gsub(/\r\n/, ' ').include? 'Another Registered Person flagged your answer'

    assert_response :success
    assert_select '.vote-total', /0.9/
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
