class UserMailer < ApplicationMailer
    default from: 'tiotangcojn@gmail.com'

    def welcome_email
        @user = params[:user]
        @url = 'http://192.168.1.36:3000'
        mail(to: @user.email, subject: 'Test Rails Email')
    end
end
