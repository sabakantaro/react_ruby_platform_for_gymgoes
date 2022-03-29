class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken

        skip_before_action :verify_authenticity_token
        helper_method :current_user, :user_signed_in?

        # def current_user
        #   @current_user ||= User.find(session[:user_id])
        # end

        # def user_signed_in?
        #   current_user != nil
        # end
      end