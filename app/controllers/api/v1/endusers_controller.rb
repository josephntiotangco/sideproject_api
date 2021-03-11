class Api::V1::EndusersController < ApplicationController
  #before_action :doorkeeper_authorize!,except: :create #, :set_enduser, only: [:show, :update, :destroy]
  before_action :set_enduser, only: [:show, :update, :create]

  # GET /endusers
  def index
    #@endusers = Enduser.all

    #render json: @endusers
    full_query = []

    status_query = ""
    status_query = " status = '#{params[:status]}'" if !params[:status].blank?
    full_query << status_query if !status_query.blank?

    enduser_code_query = ""
    enduser_code_query = " end_user_code = '#{params[:end_user_code]}'" if !params[:end_user_code].blank?
    full_query << enduser_code_query if !enduser_code_query.blank?

    enduser_contact_query = ""
    enduser_contact_query = " mobile_number = '#{params[:mobile_number]}'" if !params[:mobile_number].blank?
    full_query << enduser_contact_query if !enduser_contact_query.blank?

    enduser_type_query = ""
    enduser_type_query = " end_user_type = '#{params[:end_user_type]}'" if !params[:end_user_type].blank?
    full_query << enduser_type_query if !enduser_type_query.blank?

    #eu = Enduser.find_for_database_authentication(mobile_number: params[:email]) rescue nil

    #if eu && eu.valid_password?(params[:password])
    #  eu
    #end

    if(params[:op] == "count")
        @endusers = Enduser.select(" id, end_user_code, end_user_type, first_name, last_name, status, password ").where(full_query.join(' AND ')).paginate(:page => params[:page], :per_page => 500).count(:all)
    else
        @endusers = Enduser.select(" id, end_user_code, end_user_type, first_name, last_name, status, password ").where(full_query.join(' AND '))
    end

    if not @endusers.blank?
        render json: @endusers, status: 200
    else
        render json: {}, status: 200
    end
  end

  # GET /endusers/1
  def show
    #render json: @enduser
    @enduser = Enduser.select(" id, end_user_code, end_user_type, first_name, last_name, status ").where(id: params[:id])
    if not @enduser.blank?
        render json: @enduser, status: 200
    else
        render json: {}, status: 200
    end
  end

  # POST /endusers
  def create
    #@enduser = Enduser.new(enduser_params)

    #if @enduser.save
    #  render json: @enduser, status: :created, location: @enduser
    #else
    #  render json: @enduser.errors, status: :unprocessable_entity
    #end
    @enduser = Enduser.new(enduser_params)
    begin
        @enduser.assign_default_values
        if @enduser.save
            begin
              UserMailer.with(user: @enduser).welcome_email.deliver_now #deliver_later
            #rescue if with error in usermailer then delete created record to prevent redundancy
            rescue EOFError, IOError, TimeoutError, Errno::ECONNRESET, Errno::ECONNABORTED, Errno::EPIPE,Errno::ETIMEDOUT, Net::SMTPAuthenticationError, Net::SMTPServerBusy,Net::SMTPSyntaxError, Net::SMTPUnknownError,OpenSSL::SSL::SSLError => e
              begin
                @enduser_destroy = Enduser.find(@enduser.id)
                if not @enduser_destroy.nil?
                  @enduser_destroy.destroy
                  if @enduser_destroy.destroyed?
                    render json: { message: "ok" } and return
                  else
                    render json: { error: @enduser_destroy.errors } and return
                  end
                else
                  e.skip
                end
              rescue ActiverRecord,StandardError => e
                render json: { error: @enduser_destroy.errors, message: e.to_s } and return
              end
            end
            render json: {id: @enduser.id, end_user_code: @enduser.end_user_code, end_user_status: @enduser.status, message: 'confirmation email sent' }, status: :created
        else
            render json: {counter: @enduser.roll_back_app_counter, error: @enduser.errors}, status: :unprocessable_entity
        end
    #rescue ActiveRecord::RecordNotUnique => e
    rescue ActiveRecord, StandardError => e
        render json: {counter: @enduser.roll_back_app_counter, message: e.to_s }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /endusers/1
  def update
    set_enduser
    begin
      if @enduser.update(enduser_update_params)
        render json: { id: @enduser.id, end_user_code: @enduser.end_user_code, status: @enduser.status, email_confirmed: @enduser.email_confirmed, message: "updated" }, status: 200
      else
        render json: @enduser.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord, StandardError => e
      render json: { message: e.to_s }, status: unprocessable_entity
    end
  end

  # DELETE /endusers/1
  def destroy
    @enduser.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enduser
      @enduser = Enduser.find(params[:id])
    end
    def enduser_update_password
      params.require(:enduser).permit(:password_invalid_count)
    end
    def enduser_update_params
      params.require(:enduser).permit(:status,:email_confirmed)
    end
    # Only allow a trusted parameter "white list" through.
    def enduser_params
      params.require(:enduser).permit(:end_user_type, :first_name, :middle_name, :last_name, :contact_number, :mobile_number, :email, :password, :address_line1, :address_line2, :barangay, :barangay_name, :lot_number, :zip_code, :street_name, :district_name, :city_name)
    end
end
