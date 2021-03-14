class UserMailer < ApplicationMailer
    default from: 'tiotangcojn@gmail.com'

    def welcome_email
        @user = params[:user]
        @url = 'http://192.168.1.35:3000/api/v1/endusers?confirm_email=' + @user.email_confirm_token
        mail(to: @user.email, subject: 'Registration Confirmation')
    end
end
