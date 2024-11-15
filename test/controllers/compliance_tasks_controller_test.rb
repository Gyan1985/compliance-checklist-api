require "test_helper"

class ComplianceTasksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get compliance_tasks_index_url
    assert_response :success
  end

  test "should get create" do
    get compliance_tasks_create_url
    assert_response :success
  end

  test "should get update" do
    get compliance_tasks_update_url
    assert_response :success
  end

  test "should get destroy" do
    get compliance_tasks_destroy_url
    assert_response :success
  end
end
