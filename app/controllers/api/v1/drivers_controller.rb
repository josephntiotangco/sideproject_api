class Api::V1::DriversController < ApplicationController
    #before_action :set_driver, only: [:index, :update, :create, :show]

    #GET /drivers

    def index  
        full_query = []

        status_query = ""
        status_query = "status = '#{params[:status]}'" if !params[:status].blank?
        full_query << status_query if !status_query.blank?

        driver_code_query = ""
        driver_code_query = "Driver.driverCode = '#{params[:driverCode]}'" if !params[:driverCode].blank?
        full_query << driver_code_query if !driver_code_query.blank?

        driver_contact_query = ""
        driver_contact_query = "Driver.mobileNumber = '#{params[:mobileNumber]}'" if !params[:mobileNumber].blank?
        full_query << driver_contact_query if !driver_contact_query.blank?

        if(params[:op] == "count")
            @drivers = Driver.select(" driverCode, firstName, lastName, status ").where(full_query.join(' AND ')).paginate(:page => params[:page], :per_page => 500).count(:all)
        else
            @drivers = Driver.select(" driverCode, firstName, lastName, status ").where(full_query.join(' AND '))
        end

        if not @drivers.blank?
            render json: @drivers, status: 200
        else
            render json: {}, status: 200
        end
    end
    
    def show
        @driver_detail = Driver.select(" driverCode, firstName, lastName, status ").where(id: params[:id])
        if not @driver_detail.blank?
            render json: @driver_detail, status: 200
        else
            render json: {}, status: 200
        end
    end
    
    def update
        #set driver to driver instance
        set_driver
        if @driver.update(driver_update_params)       
            render json: {id: @driver.id, driverCode: @driver.driverCode, action: 'updated', status: 'successful' },status: 200
        else
            render json: @driver.errors, status: :unprocessable_entity
        end   
    end
    
    def create
        @driver_new = Driver.new(driver_params)
        begin
            @driver_new.assign_default_values
            if @driver_new.save
                render json: {id: @driver_new.id, driverCode: @driver_new.driverCode, action: 'created', status: 'successful'}, status: :created
            else
                render json: {counter: @driver_new.roll_back_app_counter, error: @driver_new.errors}, status: :unprocessable_entity
            end
        rescue ActiveRecord::RecordNotUnique => e
            render json: {counter: @driver_new.roll_back_app_counter, error: "Duplicate Record", message: e.to_s }, status: :unprocessable_entity
        end
    end

    private
        def set_driver
            @driver = Driver.find(params[:id])
        end
        def driver_params
            params.require(:driver).permit(:firstName, :middleName, :lastName, :mobileNumber, :otherContactNumber, :emailAddress, :addressLine1, :addressLine2, :addressBarangay, :addressBarangayName, :addressLotNumber, :addressZipCode, :addressStreetName, :addressDistrictName, :addressCityName, :driverPassword)
        end
        def driver_update_params
            params.require(:driver).permit(:firstName, :middleName, :lastName, :mobileNumber, :otherContactNumber, :emailAddress, :addressLine1, :addressLine2, :addressBarangay, :addressBarangayName, :addressLotNumber, :addressZipCode, :addressStreetName, :addressDistrictName, :addressCityName, :driverPassword)
        end
end