require 'test_helper'

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle = vehicles(:one)
  end

  test "should get index" do
    get vehicles_url, as: :json
    assert_response :success
  end

  test "should create vehicle" do
    assert_difference('Vehicle.count') do
      post vehicles_url, params: { vehicle: { driverCode: @vehicle.driverCode, id: @vehicle.id, plateNumber: @vehicle.plateNumber, registrationNumber: @vehicle.registrationNumber, seatingCapacity: @vehicle.seatingCapacity, seatingOccupied: @vehicle.seatingOccupied, status: @vehicle.status, updateDate: @vehicle.updateDate, vehicleCode: @vehicle.vehicleCode, vehicleModel: @vehicle.vehicleModel, vehicleType: @vehicle.vehicleType } }, as: :json
    end

    assert_response 201
  end

  test "should show vehicle" do
    get vehicle_url(@vehicle), as: :json
    assert_response :success
  end

  test "should update vehicle" do
    patch vehicle_url(@vehicle), params: { vehicle: { driverCode: @vehicle.driverCode, id: @vehicle.id, plateNumber: @vehicle.plateNumber, registrationNumber: @vehicle.registrationNumber, seatingCapacity: @vehicle.seatingCapacity, seatingOccupied: @vehicle.seatingOccupied, status: @vehicle.status, updateDate: @vehicle.updateDate, vehicleCode: @vehicle.vehicleCode, vehicleModel: @vehicle.vehicleModel, vehicleType: @vehicle.vehicleType } }, as: :json
    assert_response 200
  end

  test "should destroy vehicle" do
    assert_difference('Vehicle.count', -1) do
      delete vehicle_url(@vehicle), as: :json
    end

    assert_response 204
  end
end
