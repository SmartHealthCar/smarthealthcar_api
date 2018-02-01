require 'test_helper'

class CarInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car_information = car_informations(:one)
  end

  test "should get index" do
    get car_informations_url, as: :json
    assert_response :success
  end

  test "should create car_information" do
    assert_difference('CarInformation.count') do
      post car_informations_url, params: { car_information: { average_fuel_consumption: @car_information.average_fuel_consumption, average_rpm: @car_information.average_rpm, distance_traveled: @car_information.distance_traveled, end_time: @car_information.end_time, start_time: @car_information.start_time } }, as: :json
    end

    assert_response 201
  end

  test "should show car_information" do
    get car_information_url(@car_information), as: :json
    assert_response :success
  end

  test "should update car_information" do
    patch car_information_url(@car_information), params: { car_information: { average_fuel_consumption: @car_information.average_fuel_consumption, average_rpm: @car_information.average_rpm, distance_traveled: @car_information.distance_traveled, end_time: @car_information.end_time, start_time: @car_information.start_time } }, as: :json
    assert_response 200
  end

  test "should destroy car_information" do
    assert_difference('CarInformation.count', -1) do
      delete car_information_url(@car_information), as: :json
    end

    assert_response 204
  end
end
