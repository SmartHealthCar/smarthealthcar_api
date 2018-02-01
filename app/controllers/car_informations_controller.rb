class CarInformationsController < ApplicationController
  before_action :set_car_information, only: [:show, :update, :destroy]

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

    if @car_information.save
      render json: @car_information, status: :created, location: @car_information
    else
      render json: @car_information.errors, status: :unprocessable_entity
    end
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
