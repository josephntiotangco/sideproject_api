require 'test_helper'

class EndusersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @enduser = endusers(:one)
  end

  test "should get index" do
    get endusers_url, as: :json
    assert_response :success
  end

  test "should create enduser" do
    assert_difference('Enduser.count') do
      post endusers_url, params: { enduser: { address_line1: @enduser.address_line1, address_line2: @enduser.address_line2, barangay: @enduser.barangay, barangay_name: @enduser.barangay_name, city_name: @enduser.city_name, contact_number: @enduser.contact_number, district_name: @enduser.district_name, email: @enduser.email, end_user_code: @enduser.end_user_code, end_user_type: @enduser.end_user_type, first_name: @enduser.first_name, id: @enduser.id, last_name: @enduser.last_name, lot_number: @enduser.lot_number, middle_name: @enduser.middle_name, mobile_number: @enduser.mobile_number, password: @enduser.password, password_invalid_count: @enduser.password_invalid_count, password_reset_count: @enduser.password_reset_count, status: @enduser.status, street_name: @enduser.street_name, zip_code: @enduser.zip_code } }, as: :json
    end

    assert_response 201
  end

  test "should show enduser" do
    get enduser_url(@enduser), as: :json
    assert_response :success
  end

  test "should update enduser" do
    patch enduser_url(@enduser), params: { enduser: { address_line1: @enduser.address_line1, address_line2: @enduser.address_line2, barangay: @enduser.barangay, barangay_name: @enduser.barangay_name, city_name: @enduser.city_name, contact_number: @enduser.contact_number, district_name: @enduser.district_name, email: @enduser.email, end_user_code: @enduser.end_user_code, end_user_type: @enduser.end_user_type, first_name: @enduser.first_name, id: @enduser.id, last_name: @enduser.last_name, lot_number: @enduser.lot_number, middle_name: @enduser.middle_name, mobile_number: @enduser.mobile_number, password: @enduser.password, password_invalid_count: @enduser.password_invalid_count, password_reset_count: @enduser.password_reset_count, status: @enduser.status, street_name: @enduser.street_name, zip_code: @enduser.zip_code } }, as: :json
    assert_response 200
  end

  test "should destroy enduser" do
    assert_difference('Enduser.count', -1) do
      delete enduser_url(@enduser), as: :json
    end

    assert_response 204
  end
end
