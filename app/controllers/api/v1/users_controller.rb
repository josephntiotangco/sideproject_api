class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    #@users = User.all

    #render json: @users

    full_query = []

    validate_user_query = ""
    validate_user_query = "username = '#{params[:username]}'" if !params[:username].blank?
    full_query << validate_user_query if !validate_user_query.blank?
    
    validate_email_query = ""
    validate_email_query = "email = '#{params[:email]}'" if !params[:email].blank?
    full_query << validate_email_query if !validate_email_query.blank?

    validate_password_query = ""
    validate_password_query = "password = '#{params[:password]}'" if !params[:password].blank?
    full_query << validate_password_query if !validate_password_query.blank?

    su = User.find_for_database_authentication(email: params[:email]) rescue nil

    if su && su.valid_password?(params[:password])
      su
    end

    if (params[:op] == "count")
      @users = User.where(full_query.join(' AND ')).paginate(:page => params[:page], :per_page => 500).count(:all)
    else
      @users = User.where(full_query.join(' AND '))
    end

    if not @users.blank?
      render json: @users, status: 200
    else
      render json: {}, status: 200
    end
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    set_user
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_user
    #  @user = User.find(params[:id])
    #end
    def set_user
      @user = User.select("*").where(userId: params[:id])
    end  
    # Only allow a trusted parameter "white list" through.
    def user_params
        params.permit(:data)
      #params.require(:user).permit(:user_id, :user_code, :username, :email, :contact_number, :password, :encrypted_password, :create_date, :created_by, :update_date, :updated_by, :role_id, :reset_password_token, :remember_created_at, :reset_password_sent_at)
    end
end
