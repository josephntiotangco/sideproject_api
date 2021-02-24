class Api::V1::VehiclesController < ApplicationController
  #before_action :set_vehicle, only: [:show]

  # GET /vehicles
  def index
    @vehicles = Vehicle.all

    if not @vehicles.blank?
      render json: { vehicles: @vehicles }, status: 200
    else
      render json: {}, status: 200
    end

    #render json: @vehicles
  end

  # GET /vehicles/1
  def show
    if not @vehicle.blank?
      render json:{ vehicle: @vehicle }, status: 200
    else
      render json:{}, status: 200
    end
    #render json: @vehicle
  end

  # POST /vehicles
  def create
    @vehicle = Vehicle.new(vehicle_params)
    begin
      @vehicle.assign_default_values
      if @vehicle.save
        render json: @vehicle, status: :created, location: @vehicle
      else
        render json: {counter: @vehicle.roll_back_app_counte , error: @vehicle.errors } , status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique => e
      render json: {counter: @vehicle.roll_back_app_counter, error: "Duplicate Record", message: e.to_s }, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /vehicles/1
  def update
    set_vehicle
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vehicles/1
  #def destroy
  #  @vehicle.destroy
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vehicle_params
      params.require(:vehicle).permit(:plateNumber, :vehicleType, :registrationNumber, :vehicleModel, :seatingCapacity, :driverCode)
    end
end
