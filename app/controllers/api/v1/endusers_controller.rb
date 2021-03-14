class Api::V1::EndusersController < ApplicationController
  before_action :doorkeeper_authorize!, only: [:show, :update, :destroy]
  #before_action :set_enduser, only: [:show, :update, :create]
  #before_action :doorkeeper_authorize!, only: :show, :update, :destroy
  #before_action only: [:show, :update, :destroy] do
  #  doorkeeper_authorize! :admin, :write
  #end
  # GET /endusers
  def index
    #@endusers = Enduser.all

    #render json: @endusers
    full_query = []

    #status_query = ""
    #status_query = " status = '#{params[:status]}'" if !params[:status].blank?
    #full_query << status_query if !status_query.blank?

    enduser_code_query = ""
    enduser_code_query = " end_user_code = '#{params[:code]}'" if !params[:code].blank?
    full_query << enduser_code_query if !enduser_code_query.blank?

    enduser_contact_query = ""
    enduser_contact_query = " mobile_number = '#{params[:mobile]}'" if !params[:mobile].blank?
    full_query << enduser_contact_query if !enduser_contact_query.blank?

    enduser_type_query = ""
    enduser_type_query = " end_user_type = '#{params[:end_user_type]}'" if !params[:end_user_type].blank?
    full_query << enduser_type_query if !enduser_type_query.blank?

    #eu = Enduser.find_for_database_authentication(mobile_number: params[:email]) rescue nil

    #if eu && eu.valid_password?(params[:password])
    #  eu
    #end
    confirm_user_query = ""
    confirm_user_query = " email_confirm_token ='#{params[:confirm_email]}'" if !params[:confirm_email].blank?
    full_query << confirm_user_query if !confirm_user_query.blank?
    
    auth_user = params[:confirm_email]
    forget_password = params[:forget]

    if not auth_user.blank?
      if not confirm_user_query.blank?
        #@endusers = Enduser.select(" id, end_user_code, end_user_type, first_name, last_name, status, password, bind_mobile_id ").where(full_query.join(' AND '))
        @endusers = Enduser.select(" * ").where(full_query.join(' AND '))
        if not @endusers.blank?
          @enduser = @endusers.first
          if not @enduser.blank?
            #activate user by updating status, change email activation token for security
            new_token = SecureRandom.urlsafe_base64.to_s
            if @enduser.update({:status => "A", :email_confirm_token => new_token, 
              :email_confirmed => 1, :update_date => DateTime.current, :update_by => @enduser.end_user_code })
              render json: { message: "thank you!, your account is now activated..."}
              #render json: @enduser, status: 200
            else  
              render json: @enduser.errors, status: :unprocessable_entity
            end
          else
            render json: @enduser.errors, status: :unprocessable_entity
            #do nothing
          end
          #render json: @endusers, status: 200
        else
            render json: {}, status: 200
        end
      else
        #do nothing
      end
      #if(params[:op] == "count")
      #    @endusers = Enduser.select(" id, end_user_code, end_user_type, first_name, last_name, status, password, bind_mobile_id ").where(full_query.join(' AND ')).paginate(:page => params[:page], :per_page => 500).count(:all)
      #else
      #    @endusers = Enduser.select(" id, end_user_code, end_user_type, first_name, last_name, status, password, bind_mobile_id ").where(full_query.join(' AND '))
      #end
    else
      #do nothing
    end

    #if not @endusers.blank?
    #    render json: @endusers, status: 200
    #else
    #    render json: {}, status: 200
    #end
  end

  # GET /endusers/1
  def show
    #render json: @enduser
    
    @enduser = Enduser.select(" id, end_user_code, end_user_type, first_name, last_name, status, bind_mobile_id ").where(id: params[:id])
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
            render json: {id: @enduser.id, end_user_code: @enduser.end_user_code, end_user_status: @enduser.status, message: 'confirmation email sent' }, status: :created
            rescue EOFError, IOError, TimeoutError, Errno::ECONNRESET, Errno::ECONNABORTED, Errno::EPIPE,Errno::ETIMEDOUT, Net::SMTPAuthenticationError, Net::SMTPServerBusy,Net::SMTPSyntaxError, Net::SMTPUnknownError,OpenSSL::SSL::SSLError => e
              e.skip
            end          
        else
            render json: {counter: @enduser.roll_back_app_counter, error: @enduser.errors}, status: :unprocessable_entity
        end
    #rescue ActiveRecord::RecordNotUnique => e
    rescue ActiveRecord, StandardError => e     
        render json: {counter: @enduser.roll_back_app_counter, reverse: @enduser.destroy.id , message: e.to_s }, status: :unprocessable_entity
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
      params.require(:enduser).permit(:end_user_type, :first_name, :middle_name, :last_name, :contact_number, :mobile_number, :email, :password, :address_line1, :address_line2, :barangay, :barangay_name, :lot_number, :zip_code, :street_name, :district_name, :city_name, :bind_mobile_id)
    end

end
