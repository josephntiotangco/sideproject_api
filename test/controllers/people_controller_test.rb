require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get people_url, as: :json
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post people_url, params: { person: { addressBarangay: @person.addressBarangay, addressBarangayName: @person.addressBarangayName, addressCityName: @person.addressCityName, addressDistrictName: @person.addressDistrictName, addressLine1: @person.addressLine1, addressLine2: @person.addressLine2, addressLotNumber: @person.addressLotNumber, addressStreetName: @person.addressStreetName, addressZipCode: @person.addressZipCode, emailAddress: @person.emailAddress, firstName: @person.firstName, id: @person.id, lastName: @person.lastName, middleName: @person.middleName, mobileNumber: @person.mobileNumber, otherContactNumber: @person.otherContactNumber, personCode: @person.personCode, personPassword: @person.personPassword, status: @person.status } }, as: :json
    end

    assert_response 201
  end

  test "should show person" do
    get person_url(@person), as: :json
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { addressBarangay: @person.addressBarangay, addressBarangayName: @person.addressBarangayName, addressCityName: @person.addressCityName, addressDistrictName: @person.addressDistrictName, addressLine1: @person.addressLine1, addressLine2: @person.addressLine2, addressLotNumber: @person.addressLotNumber, addressStreetName: @person.addressStreetName, addressZipCode: @person.addressZipCode, emailAddress: @person.emailAddress, firstName: @person.firstName, id: @person.id, lastName: @person.lastName, middleName: @person.middleName, mobileNumber: @person.mobileNumber, otherContactNumber: @person.otherContactNumber, personCode: @person.personCode, personPassword: @person.personPassword, status: @person.status } }, as: :json
    assert_response 200
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete person_url(@person), as: :json
    end

    assert_response 204
  end
end
