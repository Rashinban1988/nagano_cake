require "test_helper"

class Admin::OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_order_items_update_url
    assert_response :success
  end
end
