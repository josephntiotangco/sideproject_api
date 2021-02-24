require 'test_helper'

class VehicleassignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicleassignment = vehicleassignments(:one)
  end

  test "should get index" do
    get vehicleassignments_url, as: :json
    assert_response :success
  end

  test "should create vehicleassignment" do
    assert_difference('Vehicleassignment.count') do
      post vehicleassignments_url, params: { vehicleassignment: { assignedAt: @vehicleassignment.assignedAt, assignedBy: @vehicleassignment.assignedBy, status: @vehicleassignment.status, updateBy: @vehicleassignment.updateBy, updateDate: @vehicleassignment.updateDate } }, as: :json
    end

    assert_response 201
  end

  test "should show vehicleassignment" do
    get vehicleassignment_url(@vehicleassignment), as: :json
    assert_response :success
  end

  test "should update vehicleassignment" do
    patch vehicleassignment_url(@vehicleassignment), params: { vehicleassignment: { assignedAt: @vehicleassignment.assignedAt, assignedBy: @vehicleassignment.assignedBy, status: @vehicleassignment.status, updateBy: @vehicleassignment.updateBy, updateDate: @vehicleassignment.updateDate } }, as: :json
    assert_response 200
  end

  test "should destroy vehicleassignment" do
    assert_difference('Vehicleassignment.count', -1) do
      delete vehicleassignment_url(@vehicleassignment), as: :json
    end

    assert_response 204
  end
end
