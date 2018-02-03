class CarInformationsController < ApplicationController
  before_action :set_car_information, only: [:show, :update, :destroy]
  before_action :set_car_info_data, only: [:get_average_rpm, :get_time_traveled, :get_odometer, :get_distance_traveled, :get_average_consumption, :get_all_data]

  # GET /car_informations
  def index
    @car_informations = CarInformation.all

    render json: @car_informations
  end

  # GET /car_informations/1
  def show
    render json: @car_information
  end

  # POST /car_informations
  def create
    @car_information = CarInformation.new(car_information_params)

    @car_information.car = Car.find_by_vin(params[:vin])

    unless @car_information.car
      @new_car = Car.create :vin => params[:vin], :odometer => params[:odometer]
      @car_information.car = @new_car
    end

    if @car_information.average_fuel_consumption == nil
      @car_information.average_fuel_consumption = 0
    end

    if @car_information.save
      render json: @car_information, status: :created, location: @car_information
    else
      render json: @car_information.errors, status: :unprocessable_entity
    end
  end

  def get_average_consumption
    @average_consumption_data = []

    @car_info_data.each do |data|
      @average_consumption_data.append({
        :data => data.average_fuel_consumption,
        :start_time => data.start_time
        })
    end

    render json: @average_consumption_data
  end

  def get_average_rpm
    @average_rpm_data = []

    @car_info_data.each do |data|
      @average_rpm_data.append({
        :data => data.average_rpm,
        :start_time => data.start_time
        })
    end

    render json: @average_rpm_data
  end

  def get_distance_traveled
    @distance_traveled_data = []

    @car_info_data.each do |data|
      @distance_traveled_data.append({
        :data => data.distance_traveled,
        :start_time => data.start_time
        })
    end

    render json: @distance_traveled_data
  end

  def get_time_traveled
    @get_time_traveled_data = []

    @car_info_data.each do |data|
      @get_time_traveled_data.append({
        :data => (data.end_time - data.start_time)/1.minute,
        :start_time => data.start_time
        })
    end

    render json: @get_time_traveled_data
  end

  def get_all_data
    @all_data = []

    @time_traveled = nil
    @start_time = Time.now.to_s

    @car_info_data.each do |data|
      if data.end_time != nil and data.start_time != nil
        time_traveled = (data.end_time - data.start_time)/1.minute
        start_time = data.start_time
      end

      @all_data.append({
        :average_fuel_consumption => data.average_fuel_consumption,
        :average_rpm => data.average_rpm,
        :time_traveled => time_traveled,
        :distance_traveled => data.distance_traveled,
        :start_time => start_time
        })
    end

    @final_data = {all_data: @all_data}

    render json: @final_data
  end

  def set_car_info_data
    if params[:vin] == "null"
      @id = CarInformation.last.car_id
      @car = Car.find_by_id(@id)
    else
      @car = Car.find_by_vin(params[:vin])
    end
    @car_info_data = CarInformation.where :car_id => @car.id
  end

  # PATCH/PUT /car_informations/1
  def update
    if @car_information.update(car_information_params)
      render json: @car_information
    else
      render json: @car_information.errors, status: :unprocessable_entity
    end
  end

  # DELETE /car_informations/1
  def destroy
    @car_information.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_information
      @car_information = CarInformation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def car_information_params
      params.require(:car_information).permit(:average_fuel_consumption, :distance_traveled, :average_rpm, :start_time, :end_time)
    end
end
