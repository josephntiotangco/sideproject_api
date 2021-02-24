class Api::V1::PeopleController < ApplicationController
  #before_action :set_person, only: [:show, :update, :destroy]

  # GET /people
  def index
    full_query = []

    status_query = ""
    status_query = "status = '#{params[:status]}'" if !params[:status].blank?
    full_query << status_query if !status_query.blank?

    person_code_query = ""
    person_code_query = "Person.personCode = '#{params[:personCode]}'" if !params[:personCode].blank?
    full_query << person_code_query if !person_code_query.blank?

    person_mobile_number_query = ""
    person_mobile_number_query = "Person.mobileNumber = '#{params[:mobileNumber]}'" if !params[:mobileNumber].blank?
    full_query << person_mobile_number_query if !person_mobile_number_query.blank?


    if(params[:op] == "count")
        @people = Person.select(" id, personCode, mobileNumber, firstName, lastName, status, personPassword ").where(full_query.join(' AND ')).paginate(:page => params[:page], :per_page => 500).count(:all)
    else
        @people = Person.select(" id, personCode, mobileNumber, firstName, lastName, status, personPassword ").where(full_query.join(' AND '))
    end

    if not @people.blank?
        render json: @people, status: 200
    else
        render json: {}, status: 200
    end
    #@people = Person.all

    #render json: @people
  end

  # GET /people/1
  def show
    #render json: @person
    @person_detail = Person.select(" personCode, firstName, lastName, status ").where(id: params[:id])
    if not @person_detail.blank?
        render json:  @person_detail , status: 200
    else
        render json: {}, status: 200
    end
  end

  # POST /people
  def create
    @person = Person.new(person_params)
    begin
      @person.assign_default_values_person
        if @person.save
          render json: {id: @person.id, personCode: @person.personCode, action: 'created', status: 'successful'}, status: :created
          #render json: @person, status: :created, location: @person
        else
          render json: {counter: @person.roll_back_app_counter, error: @person.errors }, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotUnique => e
      render json: {counter: @person.roll_back_app_counter, error: "Duplicate Record", message: e.to_s }, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /people/1
  def update
    set_person
    if @person.update(person_params)
      render json: {id: @person.id, personCode: @person.personCode, action: 'updated', status: 'successful' },status: 200
      #render json: @person, status: 200
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
      #@person = Person.select("*")
    end

    # Only allow a trusted parameter "white list" through.
    def person_params
      params.require(:person).permit(:firstName, :middleName, :lastName, :mobileNumber, :otherContactNumber, :emailAddress, :addressLine1, :addressLine2, :addressBarangay, :addressBarangayName, :addressLotNumber, :addressZipCode, :addressStreetName, :addressDistrictName, :addressCityName, :personPassword)
    end

    #def person_update_params
    #  params.require(:person).permit(:firstName, :middleName, :lastName, :mobileNumber, :otherContactNumber, :emailAddress, :addressLine1, :addressLine2, :addressBarangay, :addressBarangayName, :addressLotNumber, :addressZipCode, :addressStreetName, :addressDistrictName, :addressCityName, :personPassword)
    #end
end
